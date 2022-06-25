library(MadIsland)

island_data <- MadIsland::extract_species(
  checklist_file_name = "squamate_checklist.csv",
  phylo_file_name = "Tonini_complete_posterior_100.nex",
  dna_or_complete = "complete",
  daisie_status = FALSE,
  extraction_method = "min"
)

multi_island_tbl_complete <- island_data$multi_island_tbl
no_phylo_missing_species <- island_data$no_phylo_missing_species
complete_multi_phylods <- island_data$phylods

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
    "squamate_island_tbl_complete.rds"
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
    "squamate_daisie_datatable_complete.rds"
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
    "squamate_daisie_data_list_complete.rds"
  )
)
