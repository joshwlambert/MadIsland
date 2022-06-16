## code to prepare `madagascar_amphibians_complete_ds` dataset goes here

madagascar_amphibians_complete_ds <- process_raw_data(
  file_name = "amphibian_checklist.csv",
  dna_or_complete = "complete",
  daisie_status = TRUE
)

usethis::use_data(madagascar_amphibians_complete_ds, overwrite = TRUE)
