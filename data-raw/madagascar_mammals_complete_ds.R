## code to prepare `madagascar_mammals_complete_ds` dataset goes here

madagascar_mammals_complete_ds <- process_raw_data(
  file_name = "mammal_checklist.csv",
  dna_or_complete = "complete",
  daisie_status = TRUE
)

usethis::use_data(madagascar_mammals_complete_ds, overwrite = TRUE)
