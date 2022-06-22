library(MadIsland)

# load madagascar squamate species data table
data("madagascar_squamates_complete", package = "MadIsland")

# check that the data has loaded correctly and that it has the correct data
head(madagascar_squamates_complete)
all(
  colnames(madagascar_squamates_complete) ==
    c("tip_labels", "tip_endemicity_status")
)

# load the full raw data checklist of squamate species of madagascar
squamate_checklist <- read_checklist(file_name = "squamate_checklist.csv")

# check that the data has loaded correctly and that it has the correct data
head(squamate_checklist)
all(colnames(squamate_checklist) == c(
  "Genus", "Species", "Subspecies", "Family", "Order", "Common_Name",
  "Name_In_Tree", "Sampled", "DNA_In_Tree", "Extinct_Extant",
  "Status_Species", "DAISIE_Status_Species", "Remove_Species"
))

# count the number of missing species for each genus
missing_squamate_species <- count_missing_species(
  checklist = squamate_checklist,
  dna_or_complete = "complete"
)

# look at missing species to check
missing_squamate_species

# load the complete trees
squamate_posterior_complete <- ape::read.nexus(
  file = system.file(
    "extdata", "phylos", "Tonini_complete_posterior_100.nex",
    package = "MadIsland"
  )
)

#delete
squamate_posterior_complete <- squamate_posterior_complete[1:3]

# convert trees to phylo4 objects
complete_phylos <- lapply(squamate_posterior_complete, phylobase::phylo4)

# remove phylo objects to free up some memory
rm(squamate_posterior_complete)
gc()

# create endemicity status data frame
endemicity_status_complete <- lapply(
  complete_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_squamates_complete
)

# combine tree and endemicity status
complete_multi_phylods <- mapply(
  phylobase::phylo4d,
  complete_phylos,
  endemicity_status_complete
)

# reconstruct geographic ancestral states for extraction with asr
complete_multi_phylods <- lapply(
  complete_multi_phylods,
  DAISIEprep::add_asr_node_states,
  asr_method = "mk",
  tie_preference = "mainland"
)

# extract island community using asr algorithm
multi_island_tbl_complete <- DAISIEprep::multi_extract_island_species(
  multi_phylod = complete_multi_phylods,
  extraction_method = "asr",
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
  missing_species = list(missing_squamate_species)
)

# remove missing species that have already been inserted into the island tbl
no_phylo_missing_squamate_species_complete <- lapply(
  missing_genus_complete,
  rm_phylo_missing_species,
  missing_species = missing_squamate_species
)

# there are no missing species left to be assigned to the multi_island_tbls
no_phylo_missing_squamate_species_complete

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
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "squamate_data",
    "squamate_island_tbl_complete_asr.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "squamate_data",
    "squamate_daisie_datatable_complete_asr.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "squamate_data",
    "squamate_daisie_data_list_complete_asr.rds"
  )
)
