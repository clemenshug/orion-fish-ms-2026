

#if we have to start from the file: we can start from the ratio calculated then define the category: 

ROI_FISH_ratio_filtered <- read_csv("ROI_FISH_ratio_filt.csv")


#checking NA in dataset first: 
filter(ROI_FISH_ratio_filtered, is.na(ratio_MYC_FISH)) %>% View()

#now based on ratio, I categorised diploid and aneuploid


ROI_FISH_scoring <- ROI_FISH_ratio_filtered %>%
  mutate(
    CCNE1_category = ifelse(`ratio_CCNE1_FISH` <= 1.3, "diploid", "aneuploid") %>%
      fct_relevel("diploid"), #converts this to a factor and sets "diploid" as the reference/first level
    MYC_category = ifelse(`ratio_MYC_FISH` <= 1.3, "diploid", "aneuploid") %>%
      fct_relevel("diploid"),
  )

write_csv(ROI_FISH_scoring, "ROI_FISH_scoring_singlecells.csv")
####============

#alternatively, we can follow from Step3 script which is ROI_FISH_scoring: 


# looking at how CD8+ T cells are distributed around epithelial cells with different aneuploidy (abnormal chromosome copy number) statuses.

selected_sample_1 <- ROI_FISH_scoring %>% filter(slideName == "LSP18316")
selected_sample_2 <- ROI_FISH_scoring %>% filter(slideName == "LSP19422")
selected_sample_3 <- ROI_FISH_scoring %>% filter(slideName == "LSP18304")

plan(multisession, workers = 12)
calculate_50um_neighborhoods <- function(data, distance = 50) {
  
  neighborhood_impl <- function(data_slide, slide) {
    message("Processing ", slide, "...")
    # Calculate distance matrix

    message("Finding neighbors...")
    data_sf <- st_as_sf(data_slide,coords = c("Xt", "Yt"))
    neighbor_indices <- st_is_within_distance(
      data_sf, dist = distance, sparse = TRUE, remove_self = TRUE
    ) #For each cell, finds all other cells within 50µm
    
    message("Computing neighbor stats...")
    # For each cell, find neighbors within 50µm
    neighborhood_info <- future_map(1:nrow(data_slide), function(i) {
      cur_neighbor_idx <- neighbor_indices[[i]]
      # Get ALL neighbors
      neighbors <- data_slide[cur_neighbor_idx, ]
      
      summary_stats <- neighbors %>%
        summarize(
          across(
            where(is.logical),
            .fns = list(
              count = sum,
              pct = \(x) mean(x) * 100
            )
          ),
          total_neighbors = length(cur_neighbor_idx)
        )
      summary_stats
    }, .progress = TRUE)
    # # For each cell, find neighbors within 50µm
    # neighborhood_info <- lapply(1:nrow(data_slide), function(i) {
    #   cur_neighbor_idx <- setdiff(neighbor_indices[[i]], i)
    #   # Get ALL neighbors
    #   neighbors <- data_slide[cur_neighbor_idx, ]
    #   
    #   summary_stats <- neighbors %>%
    #     summarize(
    #       across(
    #         where(is.logical),
    #         .fns = list(
    #           count = sum,
    #           pct = \(x) mean(x) * 100
    #         )
    #       ),
    #       total_neighbors = length(cur_neighbor_idx)
    #     )
    #   summary_stats
    # })
    
    message("Assembling stats...")
    neighborhood_df <- bind_rows(
      set_names(neighborhood_info, data_slide$CellID),
      .id = "CellID"
    ) %>%
      mutate(across(CellID, as.double)) %>%
      power_left_join(
        data_slide,
        by = "CellID",
        check = check_specs(
          unmatched_keys_left = "warn",
          duplicate_keys_left = "warn",
          unmatched_keys_right = "warn",
          duplicate_keys_right = "warn"
        )
      )
  }
  neighborhood_df <- data %>%
    group_by(slideName) %>%
    group_modify(neighborhood_impl) %>%
    ungroup()
  
  
  return(neighborhood_df)
}

# Run the analysis
data_with_neighborhoods_1 <- calculate_50um_neighborhoods(selected_sample_1)

data_with_neighborhoods_2 <- calculate_50um_neighborhoods(selected_sample_2)

data_with_neighborhoods_3 <- calculate_50um_neighborhoods(selected_sample_3)

write_excel_csv(data_with_neighborhoods_1,"data_with_neighborhoods_LSP18316.csv")
write_excel_csv(data_with_neighborhoods_2,"data_with_neighborhoods_LSP19422.csv")
write_excel_csv(data_with_neighborhoods_3,"data_with_neighborhoods_LSP18304.csv")

#colSums(is.na(data_with_neighborhoods)) #checking columns have NA and how many


# NaNs in the _pct columns are a result of cells without neighbors within 50um # although it shows zero
# but there are very few cells like that, 124 in data_with_neighborhoods_2,
# filter them out


data_with_neighborhoods <- bind_rows(
  data_with_neighborhoods_1,
  data_with_neighborhoods_2,
  data_with_neighborhoods_3
) %>%
  filter(total_neighbors > 0) %>%
  drop_na()

write_csv(data_with_neighborhoods, "data_with_neighborhoods_allSTIC_v2.csv")
write_excel_csv(data_with_neighborhoods,"data_with_neighborhoods_all_STICs.csv")


################################
sum(is.na(data_with_neighborhoods$ratio_CCNE1_FISH))
sum(is.na(data_with_neighborhoods$ratio_MYC_FISH))
####################



# Only for single slide

read_csv("data_with_neighborhoods_LSP18304.csv")
LSP18304 <- data_with_neighborhoods_3
LSP19422 <- data_with_neighborhoods_2
LSP18316 <- data_with_neighborhoods_1



# marker/neighborhood combinations to test
cell_types_to_test <- c(
  "CD163p", "CD8apKi67p", "CD4pKi67p", "CD11cp", "CD68p", "CD8ap", "CD4p"
)

#glm model: generalized Linear Mixed-Effects Models 

#map loops through each cell type, \(ct) is a shorthand for function (ct)- ct represents each cell type; results are stored in a list called glm_res

#build the formula inside the loop

#paste(0): Concatenates (glues together) strings with no separator between them.then "cbind()" is adding the texts

data_with_neighborhoods <- data_with_neighborhoods %>%
  mutate(
    MYC_category = relevel(factor(MYC_category), ref = "diploid"),
    CCNE1_category = relevel(factor(CCNE1_category), ref = "diploid")
  )

glm_res <- map(
  set_names(cell_types_to_test),
  \(ct) {
    model_formula <- paste0(
      "cbind(`", ct, "_count`, total_neighbors - `", ct, "_count`) ~ MYC_category * CCNE1_category + (1 | slideName)"
    ) %>%
      as.formula()
    glmer(
      model_formula,
      data = data_with_neighborhoods %>%
        filter(PanCKp == "TRUE", total_neighbors > 0, ROIname_n == "iFT"),
      family = binomial #appropriate for count/total data
    )
  }
)

glm_res_df_3 <- glm_res %>%
  map(broom.mixed::tidy) %>%
  bind_rows(.id = "population") %>%
  mutate(
    significance = case_when(
      p.value < 0.001 ~ "***",
      p.value < 0.01  ~ "**",
      p.value < 0.05  ~ "*",
      p.value < 0.1   ~ ".",
      TRUE            ~ ""
    )
  )

write_csv(glm_res_df_3, "glm_allslides_onlyFTs_summary.csv")


