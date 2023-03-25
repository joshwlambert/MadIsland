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

# summarise nonvolant mammal island community dna data

nonvolant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "nonvolant_mammal_data",
  "nonvolant_mammal_island_tbl_dna_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = nonvolant_mammals)

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

# summarise volant mammal island community dna data

volant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "volant_mammal_data",
  "volant_mammal_island_tbl_dna_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

summarise_data(data = volant_mammals)
