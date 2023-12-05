## code to prepare `squamate_daisie_data_list_dna_ds_asr` dataset goes
## here

squamate_daisie_data_list_dna_ds_asr <- readRDS(
  file = system.file(
    "extdata",
    "extracted_data",
    "squamate_data",
    "squamate_daisie_data_list_dna_ds_asr.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

usethis::use_data(squamate_daisie_data_list_dna_ds_asr, overwrite = TRUE)
