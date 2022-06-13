# load madagascar mammals species data table
data("madagascar_mammals_dna", package = "MadIsland")

# check that the data has loaded correctly and that it has the correct data
head(madagascar_mammals_dna)
all(colnames(madagascar_mammals) == c("tip_labels", "tip_endemicity_status"))

# load the full raw data checklist of mammal species of madagascar
mammal_checklist <- read_checklist(file_name = "mammal_checklist.csv")

# check that the data has loaded correctly and that it has the correct data
head(mammal_checklist)
all(colnames(mammal_checklist) == c(
  "Genus", "Species", "Subspecies", "Family", "Order", "Common_Name",
  "Name_In_Tree", "Sampled", "DNA_In_Tree", "Extinct_Extant", "Status_Species",
  "DAISIE_Species_Status", "Remove_Species"
))

# count the number of missing species for each genus

## WHEN DNA TREE IS USED USE DNA_IN_TREE (DNA_IN_UPHAM) COLUMN OF CHECKLIST
## WHEN COMPLETE TREE IS USED USE SAMPLED_IN_TREE () COLUMN OF CHECKLIST

missing_mammal_species <- count_missing_species(
  checklist = mammal_checklist
)

# look at missing species to check
missing_mammal_species

# load the DNA only trees
mammal_posterior_dna <- ape::read.nexus(
  file = system.file(
    "extdata/Upham_dna_posterior_100.nex",
    package = "MadIsland"
  )
)

# load the complete trees
mammal_posterior_complete <- ape::read.nexus(
  file = system.file(
    "extdata/Upham_complete_posterior_100.nex",
    package = "MadIsland"
  )
)

#delete
mammal_posterior_dna <- mammal_posterior_dna[1:3]
mammal_posterior_complete <- mammal_posterior_complete[1:3]

# convert trees to phylo4 objects
dna_phylos <- lapply(mammal_posterior_dna, phylobase::phylo4)
complete_phylos <- lapply(mammal_posterior_complete, phylobase::phylo4)

# remove phylo objects to free up some memory
rm(mammal_posterior_dna)
rm(mammal_posterior_complete)
gc()

# create endemicity status data frame
endemicity_status_dna <- lapply(
  dna_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_mammals
)

endemicity_status_complete <- lapply(
  complete_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_mammals
)

# ensure dna_phylos and complete_phylos are the same length
length(dna_phylos) == length(complete_phylos)

# combine tree and endemicity status
dna_multi_phylods <- list()
complete_multi_phylods <- list()
for (i in seq_along(dna_phylos)) {
  message("Converting phylo ", i, " of ", length(dna_phylos))
  dna_multi_phylods[[i]] <- phylobase::phylo4d(
    dna_phylos[[i]],
    endemicity_status_dna[[i]]
  )
  complete_multi_phylods[[i]] <- phylobase::phylo4d(
    complete_phylos[[i]],
    endemicity_status_complete[[i]]
  )
}

# extract island community using min algorithm
multi_island_tbl_dna <- DAISIEprep::multi_extract_island_species(
  multi_phylod = dna_multi_phylods,
  extraction_method = "min",
  verbose = TRUE
)

multi_island_tbl_complete <- DAISIEprep::multi_extract_island_species(
  multi_phylod = complete_multi_phylods,
  extraction_method = "min",
  verbose = TRUE
)

# determine which island clade the missing species should be assigned to
missing_genus_dna <- lapply(
  multi_island_tbl_dna,
  unique_missing_species
)

missing_genus_complete <- lapply(
  multi_island_tbl_complete,
  unique_missing_species
)

# add missing species that match genera found in the island tbl
multi_island_tbl_dna <- mapply(
  add_phylo_missing_species,
  missing_genus_dna,
  multi_island_tbl_dna,
  missing_species = list(missing_mammal_species)
)

multi_island_tbl_complete <- mapply(
  add_phylo_missing_species,
  missing_genus_complete,
  multi_island_tbl_complete,
  missing_species = list(missing_mammal_species)
)

# remove missing species that have already been inserted into the island tbl
no_phylo_missing_mammal_species_dna <- lapply(
  missing_genus_dna,
  rm_phylo_missing_species,
  missing_species = missing_mammal_species
)

no_phylo_missing_mammal_species_complete <- lapply(
  missing_genus_complete,
  rm_phylo_missing_species,
  missing_species = missing_mammal_species
)

# go to here


mini_stem_age <- DAISIEprep::extract_stem_age(
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
  species = c("Mini_ature", "Mini_mum", "Mini_scule"))

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
