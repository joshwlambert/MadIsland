# summarise bird island community dna data

birds <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "bird_data",
  "bird_island_tbl_dna_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = birds)
