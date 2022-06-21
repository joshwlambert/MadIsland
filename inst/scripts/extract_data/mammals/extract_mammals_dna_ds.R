library(MadIsland)

# load madagascar mammals species data table
data("madagascar_mammals_dna_ds", package = "MadIsland")

# check that the data has loaded correctly and that it has the correct data
head(madagascar_mammals_dna_ds)
all(
  colnames(madagascar_mammals_dna_ds) ==
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
  dna_or_complete = "DNA"
)

# look at missing species to check
missing_mammal_species

# load the DNA only trees
mammal_posterior_dna <- ape::read.nexus(
  file = system.file(
    "extdata", "phylos", "Upham_dna_posterior_100.nex",
    package = "MadIsland"
  )
)

#delete
mammal_posterior_dna <- mammal_posterior_dna[1:3]

# convert trees to phylo4 objects
dna_phylos <- lapply(mammal_posterior_dna, phylobase::phylo4)

# remove phylo objects to free up some memory
rm(mammal_posterior_dna)
gc()

# create endemicity status data frame
endemicity_status_dna <- lapply(
  dna_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_mammals_dna_ds
)

# combine tree and endemicity status
dna_multi_phylods <- mapply(
  phylobase::phylo4d,
  dna_phylos,
  endemicity_status_dna
)

# extract island community using min algorithm
multi_island_tbl_dna <- DAISIEprep::multi_extract_island_species(
  multi_phylod = dna_multi_phylods,
  extraction_method = "min",
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
  missing_species = list(missing_mammal_species)
)

# remove missing species that have already been inserted into the island tbl
no_phylo_missing_mammal_species_dna <- lapply(
  missing_genus_dna,
  rm_phylo_missing_species,
  missing_species = missing_mammal_species
)

# check that all the missing species that have not already been assigned are the
# same between different trees in the posterior
sapply(
  list(
    no_phylo_missing_mammal_species_dna[[2]]$clade_name,
    no_phylo_missing_mammal_species_dna[[3]]$clade_name
  ), identical,
  no_phylo_missing_mammal_species_dna[[1]]$clade_name
)

# check which missing species that are not already assigned have stem ages in
# the tree, when no stem is found only one tree needs to be checked as each
# tree in the posterior contains the same species and just differs in branch
# lengths and topology, when the stem age is found, a stem age from each tree is
# required
DAISIEprep::extract_stem_age(
  genus_name = "Archaeoindris",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Babakotia",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Hadropithecus",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "min"
)

Hippopotamus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Hippopotamus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Hippopotamus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "min"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Macronycteris",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Mesopropithecus",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Pachylemur",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Plesiorycteropus",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "min"
)

# add the Archaeoindris as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
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
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
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
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Hadropithecus_stenognathus",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = c("Hadropithecus_stenognathus")
)

# add the Hippopotamus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Hippopotamus_laloumena"),
  status = list("endemic"),
  missing_species = list(2),
  branching_times = Hippopotamus_stem_age,
  min_age = list(NA),
  species = list(c(
    "Hippopotamus_laloumena",
    "Hippopotamus_lemerlei",
    "Hippopotamus_madagascariensis"
  ))
)

# add the Macronycteris as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
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
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
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
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
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
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
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
    "mammal_island_tbl_dna_ds.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "mammal_daisie_datatable_dna_ds.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "mammal_daisie_data_list_dna_ds.rds"
  )
)
