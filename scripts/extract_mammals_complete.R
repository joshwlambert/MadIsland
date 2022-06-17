library(MadIsland)

# load madagascar mammals species data table
data("madagascar_mammals_complete", package = "MadIsland")

# check that the data has loaded correctly and that it has the correct data
head(madagascar_mammals_complete)
all(
  colnames(madagascar_mammals_complete) ==
    c("tip_labels", "tip_endemicity_status")
)

# load the full raw data checklist of mammal species of madagascar
mammal_checklist <- read_checklist(file_name = "mammal_checklist.csv")

# check that the data has loaded correctly and that it has the correct data
head(mammal_checklist)
all(colnames(mammal_checklist) == c(
  "Genus", "Species", "Subspecies", "Family", "Order", "Common_Name",
  "Name_In_Tree", "Sampled", "DNA_In_Tree", "Extinct_Extant", "Status_Species",
  "DAISIE_Status_Species", "Remove_Species"
))

# count the number of missing species for each genus
missing_mammal_species <- count_missing_species(
  checklist = mammal_checklist,
  dna_or_complete = "complete"
)

# look at missing species to check
missing_mammal_species

# load the complete trees
mammal_posterior_complete <- ape::read.nexus(
  file = system.file(
    "extdata", "phylos", "Upham_complete_posterior_100.nex",
    package = "MadIsland"
  )
)

#delete
mammal_posterior_complete <- mammal_posterior_complete[1:3]

# convert trees to phylo4 objects
complete_phylos <- lapply(mammal_posterior_complete, phylobase::phylo4)

# remove phylo objects to free up some memory
rm(mammal_posterior_complete)
gc()

# create endemicity status data frame
endemicity_status_complete <- lapply(
  complete_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_mammals_complete
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
  missing_species = list(missing_mammal_species)
)

# remove missing species that have already been inserted into the island tbl
no_phylo_missing_mammal_species_complete <- lapply(
  missing_genus_complete,
  rm_phylo_missing_species,
  missing_species = missing_mammal_species
)

# check that all the missing species that have not already been assigned are the
# same between different trees in the posterior
sapply(
  list(
    no_phylo_missing_mammal_species_complete[[2]]$clade_name,
    no_phylo_missing_mammal_species_complete[[3]]$clade_name
  ), identical,
  no_phylo_missing_mammal_species_complete[[1]]$clade_name
)


# check which missing species that are not already assigned have stem ages in
# the tree, when no stem is found only one tree needs to be checked as each
# tree in the posterior contains the same species and just differs in branch
# lengths and topology, when the stem age is found, a stem age from each tree is
# required
DAISIEprep::extract_stem_age(
  genus_name = "Archaeoindris",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Babakotia",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Hadropithecus",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Macronycteris",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Mesopropithecus",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Pachylemur",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Plesiorycteropus",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

# add the Archaeoindris as an island age max age as there is no stem age in the
# tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Archaeoindris_fontoynontii",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = c("Archaeoindris_fontoynontii")
)

# add the Babakotia as an island age max age as there is no stem age in the
# tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Babakotia_radofilai",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = c("Babakotia_radofilai")
)

# add the Hadropithecus as an island age max age as there is no stem age in the
# tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Hadropithecus_stenognathus",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = c("Hadropithecus_stenognathus")
)

# add the Macronycteris as an island age max age as there is no stem age in the
# tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Macronycteris_besaoka",
  status = "endemic",
  missing_species = 1,
  branching_times = 88,
  min_age = NA,
  species = c(
    "Macronycteris_besaoka",
    "Macronycteris_cryptovalorona"
  )
)

# add the Mesopropithecus as an island age max age as there is no stem age in
# the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Mesopropithecus_dolichobrachion",
  status = "endemic",
  missing_species = 2,
  branching_times = 88,
  min_age = NA,
  species = c(
    "Mesopropithecus_dolichobrachion",
    "Mesopropithecus_globiceps",
    "Mesopropithecus_pithecoides"
  )
)

# add the Pachylemur as an island age max age as there is no stem age in
# the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Pachylemur_insignis",
  status = "endemic",
  missing_species = 1,
  branching_times = 88,
  min_age = NA,
  species = c(
    "Pachylemur_insignis",
    "Pachylemur_jullyi"
  )
)

# add the Plesiorycteropus as an island age max age as there is no stem age in
# the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Plesiorycteropus_germainepetterae",
  status = "endemic",
  missing_species = 1,
  branching_times = 88,
  min_age = NA,
  species = c(
    "Plesiorycteropus_germainepetterae",
    "Plesiorycteropus_madagascariensis"
  )
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
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "mammal_island_tbl_complete.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "mammal_daisie_datatable_complete.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "mammal_daisie_data_list_complete.rds"
  )
)
