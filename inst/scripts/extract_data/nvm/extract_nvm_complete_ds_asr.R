library(MadIsland)
# load ape to prevent class conversion issues, not 100% sure why but could be
# class-specific subsetting that is exported in ape
library(ape)

island_data <- MadIsland::extract_species(
  checklist_file_name = "nvm_checklist.csv",
  phylo_file_name = "Upham_complete_posterior_100.rds",
  dna_or_complete = "complete",
  daisie_status = TRUE,
  extraction_method = "asr",
  rate_model = "ARD"
)

multi_island_tbl_complete <- island_data$multi_island_tbl
no_island_tbl_missing_species <- island_data$no_island_tbl_missing_species
complete_multi_phylods <- island_data$phylods

# if the species has no close relatives in the island data then it can be
# checked whether those missing species that are not already assigned have
# stem ages in the tree, when no stem is found only one tree needs to be checked
# as each tree in the posterior contains the same species and just differs in
# branch lengths and topology, when the stem age is found, a stem age from each
# tree is required. In cases where a close relative is known from taxonomic
# data and is already in the island data the stem age does not need to be
# searched for as the species can be added as a missing species of its close
# relative on the island

# add the Archaeoindris as a missing species of the clade with
# Megaladapis_edwardsi in it as it is a extinct lemur species
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_missing_species,
  num_missing_species = 1,
  species_to_add_to = "Megaladapis_edwardsi"
)

# add the Babakotia as a missing species of the clade with
# Megaladapis_edwardsi in it as it is a extinct lemur species
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_missing_species,
  num_missing_species = 1,
  species_to_add_to = "Megaladapis_edwardsi"
)

# add the Hadropithecus as a missing species of the clade with
# Megaladapis_edwardsi in it as it is a extinct lemur species
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_missing_species,
  num_missing_species = 1,
  species_to_add_to = "Megaladapis_edwardsi"
)

# add the Mesopropithecus as a missing species of the clade with
# Megaladapis_edwardsi in it as it is a extinct lemur species
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_missing_species,
  num_missing_species = 3,
  species_to_add_to = "Megaladapis_edwardsi"
)

# add the Pachylemur as a missing species of the clade with
# Megaladapis_edwardsi in it as it is a extinct lemur species
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_missing_species,
  num_missing_species = 2,
  species_to_add_to = "Megaladapis_edwardsi"
)

# add the Plesiorycteropus as a missing_species of the clade with
# Tenrec_ecaudatus in it as it is a tenrec species
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_missing_species,
  num_missing_species = 2,
  species_to_add_to = "Tenrec_ecaudatus"
)

# convert all non-endemic species to max age colonisation as the phylogeny
# only has species level sampling and so the colonisation time of singleton
# non-endemics cannot be precisely extracted from the tree
multi_island_tbl_complete <- lapply(multi_island_tbl_complete, \(x) {
  index <- which(x@island_tbl$status == "nonendemic")
  x@island_tbl$col_max_age[index] <- TRUE
  x
})

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
  num_mainland_species = 500
)

# save the main data outputs
# 1) the multi_island_tbl
saveRDS(
  object = multi_island_tbl_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "nvm_data",
    "nvm_it_complete_ds_asr.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "nvm_data",
    "nvm_ddt_complete_ds_asr.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "nvm_data",
    "nvm_ddl_complete_ds_asr.rds"
  )
)
