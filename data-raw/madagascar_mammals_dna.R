## code to prepare `madagascar_mammals_dna` dataset goes here

madagascar_mammals_dna <- process_raw_data(
  file_name = "mammal_checklist.csv",
  dna_or_complete = "DNA",
  daisie_status = FALSE
)

usethis::use_data(madagascar_mammals_dna, overwrite = TRUE)
