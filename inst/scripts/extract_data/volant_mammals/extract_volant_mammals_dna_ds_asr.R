library(MadIsland)

island_data <- MadIsland::extract_species(
  checklist_file_name = "volant_mammal_checklist.csv",
  phylo_file_name = "Upham_dna_posterior_100.rds",
  dna_or_complete = "DNA",
  daisie_status = TRUE,
  extraction_method = "asr"
)

multi_island_tbl_dna <- island_data$multi_island_tbl
no_island_tbl_missing_species <- island_data$no_island_tbl_missing_species
dna_multi_phylods <- island_data$phylods

# if the species has no close relatives in the island data then it can be
# checked whether those missing species that are not already assigned have
# stem ages in the tree, when no stem is found only one tree needs to be checked
# as each tree in the posterior contains the same species and just differs in
# branch lengths and topology, when the stem age is found, a stem age from each
# tree is required. In cases where a close relative is known from taxonomic
# data and is already in the island data the stem age does not need to be
# searched for as the species can be added as a missing species of its close
# relative on the island

# add Chaerephon species as separate colonisation
Chaerephon_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Chaerephon_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Chaerephon",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Chaerephon as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Chaerephon_leucogaster"),
  status = list("nonendemic"),
  missing_species = list(0),
  col_time = Chaerephon_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Chaerephon_leucogaster"),
  clade_type = list(1)
)

# add the Macronycteris as a missing species of the clade with
# Hipposideros_commersoni in it as it is a bat species
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_missing_species,
  num_missing_species = 2,
  species_to_add_to = "Hipposideros_commersoni"
)

# extract stem age for Pipistrellus
Pipistrellus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Pipistrellus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Pipistrellus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Pipistrellus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Pipistrellus raceyi"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Pipistrellus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list(c(
    "Pipistrellus raceyi"
  )),
  clade_type = list(1)
)

# convert all non-endemic species to max age colonisation as the phylogeny
# only has species level sampling and so the colonisation time of singleton
# non-endemics cannot be precisely extracted from the tree
multi_island_tbl_dna <- lapply(multi_island_tbl_dna, \(x) {
  index <- which(x@island_tbl$status == "nonendemic")
  x@island_tbl$col_max_age[index] <- TRUE
  x
})

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
  num_mainland_species = 100
)

# save the main data outputs
# 1) the multi_island_tbl
saveRDS(
  object = multi_island_tbl_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "volant_mammal_data",
    "volant_mammal_island_tbl_dna_ds_asr.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "volant_mammal_data",
    "volant_mammal_daisie_datatable_dna_ds_asr.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "volant_mammal_data",
    "volant_mammal_daisie_data_list_dna_ds_asr.rds"
  )
)
