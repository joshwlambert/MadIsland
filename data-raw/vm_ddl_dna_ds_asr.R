## code to prepare `vm_ddl_dna_ds_asr` dataset goes here

vm_ddl_dna_ds_asr <- readRDS(
  file = system.file(
    "extdata",
    "extracted_data",
    "vm_data",
    "vm_ddl_dna_ds_asr.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

usethis::use_data(vm_ddl_dna_ds_asr, overwrite = TRUE)
