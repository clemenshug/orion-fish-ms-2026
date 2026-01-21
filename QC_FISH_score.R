

#we will use the single cell filtered metadata after the QC of DNA intensity 
ROI_file <- read_csv("sampled_cells_QC.csv") # this has all ROI, slide info, patient metadata

ROI_FISH_ratio <- ROI_file %>%
  mutate(
    ratio_CCNE1_FISH = `count_Gold-CCNE1` / `count_Cy5.5-CEP19`,
    ratio_MYC_FISH = `count_Orange-MYC` / `count_Green-CEP8`) %>%
  filter(
    is.finite(ratio_MYC_FISH),
    is.finite(ratio_CCNE1_FISH),
    !is.na(ratio_MYC_FISH),
    !is.na(ratio_CCNE1_FISH)
  )


# Check how many Inf values you have
sum(is.infinite(ROI_FISH_ratio$ratio_MYC_FISH))
sum(is.infinite(ROI_FISH_ratio$ratio_CCNE1_FISH))
sum(is.na(ROI_FISH_ratio$ratio_CCNE1_FISH))
sum(is.na(ROI_FISH_ratio$ratio_MYC_FISH))


write_excel_csv(ROI_FISH_ratio, "ROI_FISH_ratio.csv")



#now based on ratio, I categorised diploid and aneuploid


ROI_FISH_scoring <- ROI_FISH_ratio_filtered %>%
  mutate(
    CCNE1_category = ifelse(`ratio_CCNE1_FISH` <= 1.3, "diploid", "aneuploid") %>%
      fct_relevel("diploid"), 
    MYC_category = ifelse(`ratio_MYC_FISH` <= 1.3, "diploid", "aneuploid") %>%
      fct_relevel("diploid"),
  )


write_excel_csv(ROI_FISH_scoring, "ROI_FISH_scoring_sc.csv") 



















