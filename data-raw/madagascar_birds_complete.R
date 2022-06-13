## code to prepare `madagascar_birds_complete` dataset goes here

madagascar_birds_complete <- process_raw_data(
  file_name = "bird_checklist.csv",
  dna_or_complete = "complete"
)

usethis::use_data(madagascar_birds_complete, overwrite = TRUE)
