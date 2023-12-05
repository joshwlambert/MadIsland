## code to prepare `amphibian_daisie_data_list_complete_ds_asr` dataset goes
## here

amphibian_daisie_data_list_complete_ds_asr <- readRDS(
  file = system.file(
    "extdata",
    "extracted_data",
    "amphibian_data",
    "amphibian_daisie_data_list_complete_ds_asr.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

usethis::use_data(amphibian_daisie_data_list_complete_ds_asr, overwrite = TRUE)
