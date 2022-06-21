library(MadIsland)

# load the complete trees
bird_posterior_complete <- ape::read.nexus(
  file = system.file(
    "extdata", "phylos", "Jetz_complete_posterior_100.nex",
    package = "MadIsland"
  )
)

# load species names that with whether they have DNA data
bird_dna_phylogeny <- utils::read.csv(
  file = system.file(
    "extdata", "dna_species", "bird_dna_phylogeny.csv",
    package = "MadIsland"
  ),
  header = TRUE,
)

# check that the data has loaded correctly and that it has the correct data
head(bird_dna_phylogeny)
all(
  colnames(bird_dna_phylogeny) ==
    c("Name", "Data")
)

# change species names to underscore separated
bird_dna_phylogeny$Name <- gsub(
  pattern = " ",
  replacement = "_",
  x = bird_dna_phylogeny$Name
)

# prune trees to only include genetic species
dna_data <- which(bird_dna_phylogeny$Data)
dna_species <- bird_dna_phylogeny$Name[dna_data]
Jetz_dna_posterior_100 <- lapply(
  bird_posterior_complete,
  ape::keep.tip,
  tip = dna_species
)
class(Jetz_dna_posterior_100) <- "multiPhylo"

# save DNA-only trees
ape::write.nexus(
  Jetz_dna_posterior_100,
  file = file.path(
    "inst",
    "extdata",
    "phylos",
    "Jetz_dna_posterior_100.nex"
  )
)
