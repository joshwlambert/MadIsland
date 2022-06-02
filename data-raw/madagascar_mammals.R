## code to prepare `madagascar_mammals` dataset goes here

madagascar_mammals <- process_raw_data(
  file_name = "mammal_checklist.csv"
)

usethis::use_data(madagascar_mammals, overwrite = TRUE)
