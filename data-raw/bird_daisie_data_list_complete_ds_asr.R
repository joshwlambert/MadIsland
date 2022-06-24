## code to prepare `bird_daisie_data_list_complete_ds_asr` dataset goes
## here

bird_daisie_data_list_complete_ds_asr <- readRDS(
  file = system.file(
    "extdata",
    "extracted_data",
    "bird_data",
    "bird_daisie_data_list_complete_ds_asr.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

usethis::use_data(bird_daisie_data_list_complete_ds_asr, overwrite = TRUE)
