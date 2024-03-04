# summarise amphibian island community dna data

amphibians <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "amp_data",
  "amp_it_dna_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

phylo_stats(data = amphibians)

# summarise bird island community dna data

birds <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "bird_data",
  "bird_it_dna_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

phylo_stats(data = birds)

# summarise nonvolant mammal island community dna data

nonvolant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "nvm_data",
  "nvm_it_dna_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

phylo_stats(data = nonvolant_mammals)

# summarise squamate island community dna data

squamates <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "squa_data",
  "squa_it_dna_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

phylo_stats(data = squamates)

# summarise volant mammal island community dna data

volant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "vm_data",
  "vm_it_dna_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

phylo_stats(data = volant_mammals)
