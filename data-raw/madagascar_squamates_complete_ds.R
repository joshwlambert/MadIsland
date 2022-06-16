## code to prepare `madagascar_squamates_complete_ds` dataset goes here

madagascar_squamates_complete_ds <- process_raw_data(
  file_name = "squamate_checklist.csv",
  dna_or_complete = "complete",
  daisie_status = TRUE
)

usethis::use_data(madagascar_squamates_complete_ds, overwrite = TRUE)
