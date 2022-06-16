## code to prepare `madagascar_mammals_dna_ds` dataset goes here

madagascar_mammals_dna_ds <- process_raw_data(
  file_name = "mammal_checklist.csv",
  dna_or_complete = "DNA",
  daisie_status = TRUE
)

usethis::use_data(madagascar_mammals_dna_ds, overwrite = TRUE)
