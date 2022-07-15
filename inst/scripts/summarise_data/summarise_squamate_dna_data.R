# summarise squamate island community dna data

squamates <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "squamate_data",
  "squamate_island_tbl_dna_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = squamates)
