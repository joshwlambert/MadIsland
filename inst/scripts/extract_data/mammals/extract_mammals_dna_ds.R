library(MadIsland)

island_data <- extract_species(
  checklist_file_name = "mammal_checklist.csv",
  phylo_file_name = "Upham_dna_posterior_100.nex",
  dna_or_complete = "DNA",
  daisie_status = TRUE,
  extraction_method = "min"
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
