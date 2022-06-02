## code to prepare `madagascar_squamates` dataset goes here

new_madagascar_squamates <- process_raw_data(
  file_name = "squamate_checklist.csv"
)

usethis::use_data(madagascar_squamates, overwrite = TRUE)
