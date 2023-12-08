## code to prepare `amp_ddl_complete_ds_asr` dataset goes here

amp_ddl_complete_ds_asr <- readRDS(
  file = system.file(
    "extdata",
    "extracted_data",
    "amp_data",
    "amp_ddl_complete_ds_asr.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

usethis::use_data(amp_ddl_complete_ds_asr, overwrite = TRUE)
