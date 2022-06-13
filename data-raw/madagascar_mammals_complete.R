## code to prepare `madagascar_mammals_complete` dataset goes here

madagascar_mammals_complete <- process_raw_data(
  file_name = "mammal_checklist.csv",
  dna_or_complete = "complete"
)

usethis::use_data(madagascar_mammals_complete, overwrite = TRUE)
