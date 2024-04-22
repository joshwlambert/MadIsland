# summarise amphibian island community complete data
amphibians <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "amp_data",
  "amp_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

amp <- phylo_stats(data = amphibians)

# summarise bird island community complete data
birds <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "bird_data",
  "bird_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

bird <- phylo_stats(data = birds)

# summarise nonvolant mammal island community complete data
nonvolant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "nvm_data",
  "nvm_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

nvm <- phylo_stats(data = nonvolant_mammals)

# summarise squamate island community complete data
squamates <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "squa_data",
  "squa_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

squa <- phylo_stats(data = squamates)

# summarise volant mammal island community complete data
volant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "vm_data",
  "vm_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

vm <- phylo_stats(data = volant_mammals)

data.frame(
  amp = unlist(amp),
  bird = unlist(bird),
  nvm = unlist(nvm),
  squa = unlist(squa),
  vm = unlist(vm)
)
