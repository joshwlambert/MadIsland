## code to prepare `madagascar_squamates_dna_ds` dataset goes here

madagascar_squamates_dna_ds <- process_raw_data(
  file_name = "squamate_checklist.csv",
  dna_or_complete = "DNA",
  daisie_status = TRUE
)

usethis::use_data(madagascar_squamates_dna_ds, overwrite = TRUE)
