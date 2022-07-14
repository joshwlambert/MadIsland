# summarise volant mammal island community data

volant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "volant_mammal_data",
  "volant_mammal_island_tbl_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = volant_mammals)
