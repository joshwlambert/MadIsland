# summarise amphibian island community complete data

amphibians <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "amphibian_data",
  "amphibian_island_tbl_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = amphibians)
