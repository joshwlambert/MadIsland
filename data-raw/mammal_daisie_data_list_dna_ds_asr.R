## code to prepare `mammal_daisie_data_list_dna_ds_asr` dataset goes
## here

mammal_daisie_data_list_dna_ds_asr <- readRDS(
  file = system.file(
    "extdata",
    "extracted_data",
    "mammal_data",
    "mammal_daisie_data_list_dna_ds_asr.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

usethis::use_data(mammal_daisie_data_list_dna_ds_asr, overwrite = TRUE)
