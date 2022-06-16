## code to prepare `madagascar_birds_dna` dataset goes here

madagascar_birds_dna <- process_raw_data(
  file_name = "bird_checklist.csv",
  dna_or_complete = "DNA",
  daisie_status = FALSE
)

usethis::use_data(madagascar_birds_dna, overwrite = TRUE)
