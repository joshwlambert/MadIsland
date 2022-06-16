## code to prepare `madagascar_squamates_dna` dataset goes here

madagascar_squamates_dna <- process_raw_data(
  file_name = "squamate_checklist.csv",
  dna_or_complete = "DNA",
  daisie_status = FALSE
)

usethis::use_data(madagascar_squamates_dna, overwrite = TRUE)
