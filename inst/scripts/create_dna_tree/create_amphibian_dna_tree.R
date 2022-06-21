library(MadIsland)

# load the complete trees
amphibian_posterior_complete <- ape::read.nexus(
  file = system.file(
    "extdata", "phylos", "Jetz_Pyron_complete_posterior_100.nex",
    package = "MadIsland"
  )
)

# load species names that with whether they have DNA data
amphibian_dna_phylogeny <- utils::read.csv(
  file = system.file(
    "extdata", "dna_species", "amphibian_dna_phylogeny.csv",
    package = "MadIsland"
  ),
  header = TRUE,
)

# check that the data has loaded correctly and that it has the correct data
head(amphibian_dna_phylogeny)
all(
  colnames(amphibian_dna_phylogeny) ==
    c("Name", "Data", "Genes")
)

# change species names to underscore separated
amphibian_dna_phylogeny$Name <- gsub(
  pattern = " ",
  replacement = "_",
  x = amphibian_dna_phylogeny$Name
)

# check that Data and Genes columns correspond
dna_data <- amphibian_dna_phylogeny$Data > 0
num_genes <- amphibian_dna_phylogeny$Genes > 0
identical(dna_data, num_genes)

# prune trees to only include genetic species
dna_species <- amphibian_dna_phylogeny$Name[which(dna_data)]
Jetz_Pyron_dna_posterior_100 <- lapply(
  amphibian_posterior_complete,
  ape::keep.tip,
  tip = dna_species
)
class(Jetz_Pyron_dna_posterior_100) <- "multiPhylo"

# save DNA-only trees
ape::write.nexus(
  Jetz_Pyron_dna_posterior_100,
  file = file.path(
    "inst",
    "extdata",
    "phylos",
    "Jetz_Pyron_dna_posterior_100.nex"
  )
)
