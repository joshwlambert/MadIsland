## code to prepare `nonvolant_mammal_daisie_data_list_complete_ds_asr` dataset
## goes here

nonvolant_mammal_daisie_data_list_complete_ds_asr <- readRDS(
  file = system.file(
    "extdata",
    "extracted_data",
    "nonvolant_mammal_data",
    "nonvolant_mammal_daisie_data_list_complete_ds_asr.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

usethis::use_data(
  nonvolant_mammal_daisie_data_list_complete_ds_asr,
  overwrite = TRUE
)
