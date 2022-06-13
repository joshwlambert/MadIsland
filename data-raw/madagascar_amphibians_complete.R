## code to prepare `madagascar_amphibians_complete` dataset goes here

madagascar_amphibians_complete <- process_raw_data(
  file_name = "amphibian_checklist.csv",
  dna_or_complete = "complete"
)

usethis::use_data(madagascar_amphibians_complete, overwrite = TRUE)
