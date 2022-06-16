## code to prepare `madagascar_squamates_complete` dataset goes here

madagascar_squamates_complete <- process_raw_data(
  file_name = "squamate_checklist.csv",
  dna_or_complete = "complete",
  daisie_status = FALSE
)

usethis::use_data(madagascar_squamates_complete, overwrite = TRUE)
