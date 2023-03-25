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

# summarise bird island community complete data

birds <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "bird_data",
  "bird_island_tbl_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = birds)

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

# summarise squamate island community complete data

squamates <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "squamate_data",
  "squamate_island_tbl_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = squamates)

# summarise volant mammal island community complete data

volant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "volant_mammal_data",
  "volant_mammal_island_tbl_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = volant_mammals)
