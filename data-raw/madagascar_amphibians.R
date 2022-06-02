## code to prepare `madagascar_amphibians` dataset goes here

madagascar_amphibians <- process_raw_data(
  file_name = "amphibian_checklist.csv"
)

usethis::use_data(madagascar_amphibians, overwrite = TRUE)
