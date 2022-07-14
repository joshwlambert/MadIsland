# summarise nonvolant mammal island community complete data

nonvolant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "nonvolant_mammal_data",
  "nonvolant_mammal_island_tbl_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = nonvolant_mammals)
