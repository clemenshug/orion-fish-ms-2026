library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)


#For QC, we use single cell data frame

#single cell output from the cycif importer script


df <- read_csv("sampled_cells.csv")

#filter out only epithelium to do some QC based on DNA intensity:

library(hexbin)
library(ggExtra)


#filter out any DNA with 0 and log transformed the intensity value of DAPI/Hoechst


df_log <- df %>%
  filter(`Hoechst-ORION` != 0 & `Hoechst-FISH` != 0) %>% #filter out the DAPI = 0 first
  mutate(
    Hoechst_ORION = log10(`Hoechst-ORION`),
    Hoechst_FISH = log10(`Hoechst-FISH`),
  )

df_log_epi <- df_log %>%
  filter(PanCKp == "TRUE") %>% #only QC on epithelium 
  filter(slideName == "LSP18316")

# Create the joint plot with hexagonal binning
hexbins <-ggplot(df_log_epi, aes(x = Hoechst_ORION, y = Hoechst_FISH)) +
  geom_hex(bins = 100) +
  geom_point(alpha = 0) + #just to staisfy the ggmarginal
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(
    x = "Hoechst_ORION_epithelium",
    y = "DAPI_FISH_epithelium"
  ) +
  theme_minimal()
hexbins

ggMarginal(hexbins, type = "histogram", fill = "steelblue", alpha = 0.7) # histogram on top

#calculating cooks distance for QC : mainly to get rid off the cells been lost during FISH

mod <- lm(`Hoechst_FISH` ~ `Hoechst_ORION`, data = df_log_epi)
summary(mod)
df_log_cooks <- df_log_epi %>%
  mutate(
    cooks_d = cooks.distance(mod),
    residuals = residuals(mod)
    # mahalonobis = {
    #   mat <- cbind(Hoechst_ORION, Hoechst_FISH)
    #   stats::mahalanobis(
    #     mat,
    #     center = colMeans(mat),
    #     cov = cov(mat)
    #   )
    # }
  )

#calculating the cell proportions to get rid off the cells
#dont want to get rid off the cells above the line
##### No need to run this block if we know the cut off
possible_cutoffs <- c(.0001, .0005, .001, .005)

df_log_cooks %>%
  crossing(cutoff = possible_cutoffs) %>%
  group_by(cutoff) %>%
  summarize(
    n = sum(cooks_d > cutoff),
    prop = n / n()
  )

#### instead run this block since the threshold is defined

PROPOSED_COOKS_THRESHOLD <- 0.0001 # here defining the threshold 
p <- ggplot(
  df_log_cooks,
  aes(
    x = Hoechst_ORION, y = Hoechst_FISH,
    text = paste("Cell ID:", CellID)
  )
) +
  geom_point(
    aes(
      fill = cooks_d,
      color = cooks_d > PROPOSED_COOKS_THRESHOLD #here using the threshold as defined as above
    ),
    shape = 21
  ) +
  geom_smooth(method = "lm") +
  labs(
    x = "Hoechst_ORION_epithelium",
    y = "DAPI_FISH_epithelium"
  ) +
  scale_color_manual(values = c(`TRUE` = "red", `FALSE` = "lightblue")) +
  labs(
    color = "Cooks pass/fail"
  ) +
  # scale_color_continuous(trans = "log") +
  theme_minimal()
p




df_log_cooks %>%
  filter(
    cooks_d > PROPOSED_COOKS_THRESHOLD
  ) %>%
  write_csv("LSP18316_outlier_points.csv") #this file can be used to check on individual cells on napari

#to generate the final quantification file to filter out the failed cells later on:

df_log_cooks_qc <- df_log_cooks %>%
  mutate(
    pass_cooks_qc = if_else(
      residuals < 0 & cooks_d > PROPOSED_COOKS_THRESHOLD,
      "fail",
      "pass"
    )
  )

write_csv(df_log_cooks_qc, "LSP18316_cooks_qc_quant.csv") # quant file for the next QC 


#plotting to show the passed and failed cells

p <- ggplot(
  df_log_cooks_qc,
  aes(
    x = Hoechst_ORION, y = Hoechst_FISH,
    text = paste("Cell ID:", CellID)
  )
) +
  geom_point(
    aes(
      fill = cooks_d,
      color = pass_cooks_qc
    ),
    shape = 21
  ) +
  geom_smooth(method = "lm") +
  labs(
    x = "Hoechst_ORION_epithelium",
    y = "DAPI_FISH_epithelium"
  ) +
  scale_color_manual(values = c(fail = "red", pass = "lightblue")) +
  # scale_color_continuous(trans = "log") +
  theme_minimal()
p

#interactive to find out the cell ID
plotly::ggplotly(p)


#This is to find out the particular cell from XY coordinates from napari


df_log_cooks %>%
  filter(abs(Xt-13237*0.325)<1,abs(Yt-10125*0.325)<1)

df_log_cooks_qc %>%
  mutate(chosen_cell = CellID == 119165) %>%
  arrange(chosen_cell) %>%
  ggplot(aes(x = Hoechst_ORION, y = Hoechst_FISH)) +
  geom_point(
    aes(
      fill = cooks_d,
      color = chosen_cell
    ),
    shape = 21
  ) +
  geom_smooth(method = "lm") +
  labs(
    x = "Hoechst_ORION_epithelium",
    y = "DAPI_FISH_epithelium"
  ) +
  scale_color_manual(values = c(`TRUE` = "red", `FALSE` = NA)) +
  # scale_color_continuous(trans = "log") +
  theme_minimal()



#now only keeping cells with passed cooksqc:
df_QC <- read_csv("LSP18316_cooks_qc_quant.csv")

df_QC_pass <- df_log_cooks_qc %>%
  filter(pass_cooks_qc == "pass") #only passed cells
write_csv(df_QC_pass, "LSP18316_QC_quant_epi.csv")


#now have the single_cell files from all 3 samples into one dataframe

LSP18304 <- read_csv("LSP18304_QC_quant_epi.csv")
LSP18316 <- read_csv("LSP18316_QC_quant_epi.csv")
LSP19422 <- read_csv("LSP19422_QC_quant_epi.csv")


#now combined using rbind since they have identical columns in the same order
combined_sample_cells_epithelium <- bind_rows(LSP18304, LSP18316, LSP19422)


#optional
#now want to delete those extra rows with cooks ID since I have already filtered out the passed cells

combined_sample_cells_epithelium2 <- combined_sample_cells_epithelium %>% select(-cooks_d, -residuals, -pass_cooks_qc)


#now I want to filter out those cells which has no FISH signal (technical reason not all cells will have signals)

combined_sample_cells_epithelium3 <- combined_sample_cells_epithelium2 %>%
  filter(`count_Green-CEP8` != 0 & `count_Gold-CCNE1` != 0 & `count_Orange-MYC` !=0 & `count_Cy5.5-CEP19` !=0) #remove any of these columns are zero



#check if zero values exist in the filtered dataset:

sum(combined_sample_cells_epithelium3$`count_Green-CEP8` == 0)
sum(combined_sample_cells_epithelium3$`count_Gold-CCNE1` == 0)
sum(combined_sample_cells_epithelium3$`count_Orange-MYC` == 0)
sum(combined_sample_cells_epithelium3$`count_Cy5.5-CEP19` == 0)

write_csv(combined_sample_cells_epithelium3, "sampled_cells_qc_epi_F.csv")

#now have to filter out the stroma
df <- read_csv("sampled_cells.csv")

sampled_cells_qc_stroma <- df_log %>%
  filter(PanCKp == "FALSE") #only QC on stroma
  

write_csv(sampled_cells_qc_stroma, "sampled_cells_qc_stroma.csv")


#now I want to combine both panck pos and panck neg dataframes: 

sampled_cells_QC <- bind_rows(sampled_cells_qc_stroma, combined_sample_cells_epithelium3)

write_csv(sampled_cells_QC, "sampled_cells_QC.csv") #This is the merged Qcd dataset

#if you have to any other filtering you can do it here. For eg. 







