## code to prepare `squa_ddl_complete_ds_asr` dataset goes here

squa_ddl_complete_ds_asr <- readRDS(
  file = system.file(
    "extdata",
    "extracted_data",
    "squa_data",
    "squa_ddl_complete_ds_asr.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

usethis::use_data(squa_ddl_complete_ds_asr, overwrite = TRUE)
