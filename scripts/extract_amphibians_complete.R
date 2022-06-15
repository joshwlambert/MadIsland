library(MadIsland)

# load madagascar amphibians species data table
data("madagascar_amphibians_complete", package = "MadIsland")

# check that the data has loaded correctly and that it has the correct data
head(madagascar_amphibians_complete)
all(
  colnames(madagascar_amphibians_complete) ==
    c("tip_labels", "tip_endemicity_status")
)

# load the full raw data checklist of amphibian species of madagascar
amphibian_checklist <- read_checklist(file_name = "amphibian_checklist.csv")

# check that the data has loaded correctly and that it has the correct data
head(amphibian_checklist)
all(colnames(amphibian_checklist) == c(
  "Genus", "Species", "Subspecies", "Family", "Order", "Common_Name",
  "Name_In_Tree", "Sampled", "DNA_In_Tree", "Extinct_Extant",
  "Status_Species", "DAISIE_Status_Species", "Remove_Species"
))

# count the number of missing species for each genus
missing_amphibian_species <- count_missing_species(
  checklist = amphibian_checklist,
  dna_or_complete = "complete"
)

# look at missing species to check
missing_amphibian_species

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
  island_species = madagascar_amphibians_complete
)

# combine tree and endemicity status
complete_multi_phylods <- mapply(
  phylobase::phylo4d,
  complete_phylos,
  endemicity_status_complete
)

# extract island community using min algorithm
multi_island_tbl_complete <- DAISIEprep::multi_extract_island_species(
  multi_phylod = complete_multi_phylods,
  extraction_method = "min",
  verbose = TRUE
)

# determine which island clade the missing species should be assigned to
missing_genus_complete <- lapply(
  multi_island_tbl_complete,
  unique_missing_species
)

# add missing species that match genera found in the island tbl
multi_island_tbl_complete <- mapply(
  add_phylo_missing_species,
  missing_genus_complete,
  multi_island_tbl_complete,
  missing_species = list(missing_amphibian_species)
)

# remove missing species that have already been inserted into the island tbl
no_phylo_missing_amphibian_species_complete <- lapply(
  missing_genus_complete,
  rm_phylo_missing_species,
  missing_species = missing_amphibian_species
)

# check that all the missing species that have not already been assigned are the
# same between different trees in the posterior
sapply(
  list(
    no_phylo_missing_amphibian_species_complete[[2]]$clade_name,
    no_phylo_missing_amphibian_species_complete[[3]]$clade_name
  ), identical,
  no_phylo_missing_amphibian_species_complete[[1]]$clade_name
)

# check which missing species that are not already assigned have stem ages in
# the tree, when no stem is found only one tree needs to be checked as each
# tree in the posterior contains the same species and just differs in branch
# lengths and topology, when the stem age is found, a stem age from each tree is
# required
DAISIEprep::extract_stem_age(
  genus_name = "Mini",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

# add the Mini as an island age max age as there is no stem age in the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Mini_ature",
  status = "endemic",
  missing_species = 3,
  branching_times = 88,
  min_age = NA,
  species = c("Mini_ature", "Mini_mum", "Mini_scule")
)

# convert to daisie data table
daisie_datatable_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::as_daisie_datatable,
  island_age = 88
)

# convert to daisie data list
daisie_data_list_complete <- lapply(
  daisie_datatable_complete,
  DAISIEprep::create_daisie_data,
  island_age = 88,
  num_mainland_species = 1000
)

# save the main data outputs
# 1) the multi_island_tbl
saveRDS(
  object = multi_island_tbl_complete,
  file = "inst/extdata/amphibian_island_tbl_complete.rds"
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_complete,
  file = "inst/extdata/amphibian_daisie_datatable_complete.rds"
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_complete,
  file = "inst/extdata/amphibian_daisie_data_list_complete.rds"
)
