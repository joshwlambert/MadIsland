library(MadIsland)

# load the complete trees
squamate_posterior_complete <- ape::read.nexus(
  file = system.file(
    "extdata", "phylos", "Tonini_complete_posterior_100.nex",
    package = "MadIsland"
  )
)

# load species names that with whether they have DNA data
squamate_dna_phylogeny <- utils::read.csv(
  file = system.file(
    "extdata", "dna_species", "squamate_dna_phylogeny.csv",
    package = "MadIsland"
  ),
  header = TRUE,
)

# check that the data has loaded correctly and that it has the correct data
head(squamate_dna_phylogeny)
all(
  colnames(squamate_dna_phylogeny) ==
    c("Name", "Genes", "Length")
)

# change species names to underscore separated
squamate_dna_phylogeny$Name <- gsub(
  pattern = " ",
  replacement = "_",
  x = squamate_dna_phylogeny$Name
)

# check that Data and Genes columns correspond
dna_data <- squamate_dna_phylogeny$Genes > 0
length_genes <- squamate_dna_phylogeny$Genes > 0
identical(dna_data, length_genes)

# prune trees to only include genetic species
dna_species <- squamate_dna_phylogeny$Name[which(dna_data)]
Tonini_dna_posterior_100 <- lapply(
  squamate_posterior_complete,
  ape::keep.tip,
  tip = dna_species
)

class(Tonini_dna_posterior_100) <- "multiPhylo"

# save DNA-only trees
ape::write.nexus(
  Tonini_dna_posterior_100,
  file = file.path(
    "inst",
    "extdata",
    "phylos",
    "Tonini_dna_posterior_100.nex"
  )
)
