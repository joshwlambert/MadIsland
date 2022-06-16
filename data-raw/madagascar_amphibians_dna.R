## code to prepare `madagascar_amphibians_dna` dataset goes here

madagascar_amphibians_dna <- process_raw_data(
  file_name = "amphibian_checklist.csv",
  dna_or_complete = "DNA",
  daisie_status = FALSE
)

usethis::use_data(madagascar_amphibians_dna, overwrite = TRUE)
