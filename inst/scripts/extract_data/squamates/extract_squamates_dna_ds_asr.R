library(MadIsland)

island_data <- extract_species(
  checklist_file_name = "squamate_checklist.csv",
  phylo_file_name = "Tonini_dna_posterior_100.nex",
  dna_or_complete = "DNA",
  daisie_status = TRUE,
  extraction_method = "asr"
)

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
    "squamate_island_tbl_dna_ds_asr.rds"
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
    "squamate_daisie_datatable_dna_ds_asr.rds"
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
    "squamate_daisie_data_list_dna_ds_asr.rds"
  )
)
