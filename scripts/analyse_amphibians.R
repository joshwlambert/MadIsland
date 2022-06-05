# load madagascar amphibians species data table
data("madagascar_amphibians", package = "MadIsland")

# check that the data has loaded correctly and that it has the correct data
head(madagascar_amphibians)
all(colnames(madagascar_amphibians) == c("tip_labels", "tip_endemicity_status"))

# load the full raw data checklist of amphibian species of madagascar
amphibian_checklist <- read_checklist(file_name = "amphibian_checklist.csv")

# check that the data has loaded correctly and that it has the correct data
head(amphibian_checklist)
all(colnames(amphibian_checklist) == c(
  "Genus", "Species", "Subspecies", "Family", "Order", "Common_Name",
  "Our_Name", "Name_In_Tree", "Sampled", "DNA_In_Tree", "Extinct_Extant",
  "Status_Species", "DAISIE_Species_Status", "Remove_Species"
))

# count the number of missing species for each genus
missing_amphibian_species <- count_missing_species(
  checklist = amphibian_checklist
)

# load the complete trees
amphibian_posterior_complete <- ape::read.nexus(
  file = system.file(
    "extdata/Jetz_Pyron_complete_posterior_100.nex",
    package = "MadIsland"
  )
)

#delete
amphibian_posterior_complete <- amphibian_posterior_complete[1:3]

# convert trees to phylo4 objects
complete_phylos <- lapply(amphibian_posterior_complete, phylobase::phylo4)

# remove phylo objects to free up some memory
rm(amphibian_posterior_complete)
gc()

# create endemicity status data frame
endemicity_status_complete <- lapply(
  complete_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_amphibians
)

# combine tree and endemicity status
complete_multi_phylods <- list()
for (i in seq_along(complete_phylos)) {
  message("Converting phylo ", i, " of ", length(complete_phylos))
  complete_multi_phylods[[i]] <- phylobase::phylo4d(
    complete_phylos[[i]],
    endemicity_status_complete[[i]]
  )
}

# extract island community using min algorithm
multi_island_tbl_complete <- DAISIEprep::multi_extract_island_species(
  multi_phylod = complete_multi_phylods,
  extraction_method = "min",
  verbose = TRUE
)

missing_genus <- lapply(multi_island_tbl_complete, unique_missing_species)

# add missing species that match genera found in the island tbl
multi_island_tbl_complete <- mapply(
  add_phylo_missing_species,
  missing_genus,
  multi_island_tbl_complete,
  missing_species = list(missing_amphibian_species)
)

# remove missing species that have already been inserted into the island tbl
no_phylo_missing_amphibian_species <- lapply(
  missing_genus,
  rm_phylo_missing_species,
  missing_species = missing_amphibian_species
)

mini_stem_age <- DAISIEprep::extract_stem_age(
  genus_name = "Mini",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

complete_multi_phylods[[1]] <- DAISIEprep::add_island_colonist(
  island_tbl = multi_island_tbl_complete[[1]],
  clade_name = "Mini",
  status = "endemic",
  missing_species = 3,
  branching_times = 88,
  min_age = NA,
  species = c(...)
)
