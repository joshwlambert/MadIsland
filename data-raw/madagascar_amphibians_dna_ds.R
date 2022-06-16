## code to prepare `madagascar_amphibians_dna_ds` dataset goes here

madagascar_amphibians_dna_ds <- process_raw_data(
  file_name = "amphibian_checklist.csv",
  dna_or_complete = "DNA",
  daisie_status = TRUE
)

usethis::use_data(madagascar_amphibians_dna_ds, overwrite = TRUE)
