## code to prepare `volant_mammal_daisie_data_list_complete_ds_asr` dataset goes
## here

volant_mammal_daisie_data_list_complete_ds_asr <- readRDS(
  file = system.file(
    "extdata",
    "extracted_data",
    "volant_mammal_data",
    "volant_mammal_daisie_data_list_complete_ds_asr.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

usethis::use_data(
  volant_mammal_daisie_data_list_complete_ds_asr,
  overwrite = TRUE
)
