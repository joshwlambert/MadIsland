library(MadIsland)

island_data <- extract_species(
  checklist_file_name = "amphibian_checklist.csv",
  phylo_file_name = "Jetz_Pyron_complete_posterior_100.nex",
  dna_or_complete = "complete",
  daisie_status = FALSE,
  extraction_method = "asr"
)

# check which missing species that are not already assigned have stem ages in
# the tree, when no stem is found only one tree needs to be checked as each
# tree in the posterior contains the same species and just differs in branch
# lengths and topology, when the stem age is found, a stem age from each tree is
# required
DAISIEprep::extract_stem_age(
  genus_name = "Mini",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "asr"
)

# add the Mini as an island age max age as there is no stem age in the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Mini_ature",
  status = "endemic",
  missing_species = 2,
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
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "amphibian_data",
    "amphibian_island_tbl_complete_asr.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "amphibian_data",
    "amphibian_daisie_datatable_complete_asr.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "amphibian_data",
    "amphibian_daisie_data_list_complete_asr.rds"
  )
)
