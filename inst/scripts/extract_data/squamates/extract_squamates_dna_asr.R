library(MadIsland)

# load madagascar squamate species data table
data("madagascar_squamates_dna", package = "MadIsland")

# check that the data has loaded correctly and that it has the correct data
head(madagascar_squamates_dna)
all(
  colnames(madagascar_squamates_dna) ==
    c("tip_labels", "tip_endemicity_status")
)

# load the full raw data checklist of squamate species of madagascar
squamate_checklist <- read_checklist(file_name = "squamate_checklist.csv")

# check that the data has loaded correctly and that it has the correct data
head(squamate_checklist)
all(colnames(squamate_checklist) == c(
  "Genus", "Species", "Subspecies", "Family", "Order", "Common_Name",
  "Name_In_Tree", "Sampled", "DNA_In_Tree", "Extinct_Extant", "Status_Species",
  "DAISIE_Status_Species", "Remove_Species"
))

# count the number of missing species for each genus
missing_squamate_species <- count_missing_species(
  checklist = squamate_checklist,
  dna_or_complete = "DNA"
)

# look at missing species to check
missing_squamate_species

# load the DNA-only trees
squamate_posterior_dna <- ape::read.nexus(
  file = system.file(
    "extdata", "phylos", "Tonini_dna_posterior_100.nex",
    package = "MadIsland"
  )
)

#delete
squamate_posterior_dna <- squamate_posterior_dna[1:3]

# convert trees to phylo4 objects
dna_phylos <- lapply(squamate_posterior_dna, phylobase::phylo4)

# remove phylo objects to free up some memory
rm(squamate_posterior_dna)
gc()

# create endemicity status data frame
endemicity_status_dna <- lapply(
  dna_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_squamates_dna
)

# combine tree and endemicity status
dna_multi_phylods <- mapply(
  phylobase::phylo4d,
  dna_phylos,
  endemicity_status_dna
)

# reconstruct geographic ancestral states for extraction with asr
dna_multi_phylods <- lapply(
  dna_multi_phylods,
  DAISIEprep::add_asr_node_states,
  asr_method = "mk",
  tie_preference = "mainland"
)

# extract island community using asr algorithm
multi_island_tbl_dna <- DAISIEprep::multi_extract_island_species(
  multi_phylod = dna_multi_phylods,
  extraction_method = "asr",
  verbose = TRUE
)

# determine which island clade the missing species should be assigned to
missing_genus_dna <- lapply(
  multi_island_tbl_dna,
  unique_missing_species
)

# add missing species that match genera found in the island tbl
multi_island_tbl_dna <- mapply(
  add_phylo_missing_species,
  missing_genus_dna,
  multi_island_tbl_dna,
  missing_species = list(missing_squamate_species)
)

# remove missing species that have already been inserted into the island tbl
no_phylo_missing_squamate_species_dna <- lapply(
  missing_genus_dna,
  rm_phylo_missing_species,
  missing_species = missing_squamate_species
)

# check that all the missing species that have not already been assigned are the
# same between different trees in the posterior
sapply(
  list(
    no_phylo_missing_squamate_species_dna[[2]]$clade_name,
    no_phylo_missing_squamate_species_dna[[3]]$clade_name
  ), identical,
  no_phylo_missing_squamate_species_dna[[1]]$clade_name
)

##########################################################
##########################################################

island_data <- extract_species(
  checklist_file_name = "squamate_checklist.csv",
  phylo_file_name = "Tonini_dna_posterior_100.nex",
  dna_or_complete = "DNA",
  daisie_status = FALSE,
  extraction_method = "asr"
)

identical(island_data$multi_island_tbl, multi_island_tbl_dna)
identical(
  island_data$no_phylo_missing_species,
  no_phylo_missing_squamate_species_dna
)
waldo::compare(island_data$multi_island_tbl, multi_island_tbl_dna)
waldo::compare(
  island_data$no_phylo_missing_species,
  no_phylo_missing_squamate_species_dna
)
##########################################################
##########################################################

# check which missing species that are not already assigned have stem ages in
# the tree, when no stem is found only one tree needs to be checked as each
# tree in the posterior contains the same species and just differs in branch
# lengths and topology, when the stem age is found, a stem age from each tree is
# required
DAISIEprep::extract_stem_age(
  genus_name = "Brygophis",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

DAISIEprep::extract_stem_age(
  genus_name = "Pararhadinaea",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

DAISIEprep::extract_stem_age(
  genus_name = "Sirenoscincus",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

# add the Brygophis as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Brygophis_coulangesi",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = c("Brygophis_coulangesi")
)

# add the Pararhadinaea as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Pararhadinaea_melanogaster",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = c("Pararhadinaea_melanogaster")
)

# add the Sirenoscincus as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Sirenoscincus_mobydick",
  status = "endemic",
  missing_species = 1,
  branching_times = 88,
  min_age = NA,
  species = c(
    "Sirenoscincus_mobydick",
    "Sirenoscincus_yamagishii"
  )
)

# convert to daisie data table
daisie_datatable_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::as_daisie_datatable,
  island_age = 88
)

# convert to daisie data list
daisie_data_list_dna <- lapply(
  daisie_datatable_dna,
  DAISIEprep::create_daisie_data,
  island_age = 88,
  num_mainland_species = 1000
)

# save the main data outputs
# 1) the multi_island_tbl
saveRDS(
  object = multi_island_tbl_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "squamate_data",
    "squamate_island_tbl_dna_asr.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "squamate_data",
    "squamate_daisie_datatable_dna_asr.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "squamate_data",
    "squamate_daisie_data_list_dna_asr.rds"
  )
)
