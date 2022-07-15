# summarise amphibian island community dna data

amphibians <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "amphibian_data",
  "amphibian_island_tbl_dna_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = amphibians)
