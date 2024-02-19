# summarise amphibian island community complete data

amphibians <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "amp_data",
  "amp_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

phylo_stats(data = amphibians)

# summarise bird island community complete data

birds <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "bird_data",
  "bird_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

phylo_stats(data = birds)

# summarise nonvolant mammal island community complete data

nonvolant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "nonvolant_mammal_data",
  "nonvolant_mammal_island_tbl_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

phylo_stats(data = nonvolant_mammals)

# summarise squamate island community complete data

squamates <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "squamate_data",
  "squamate_island_tbl_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

phylo_stats(data = squamates)

# summarise volant mammal island community complete data

volant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "volant_mammal_data",
  "volant_mammal_island_tbl_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

phylo_stats(data = volant_mammals)
