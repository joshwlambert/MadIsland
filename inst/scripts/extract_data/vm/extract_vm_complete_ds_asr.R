library(MadIsland)
# load ape to prevent class conversion issues, not 100% sure why but could be
# class-specific subsetting that is exported in ape
library(ape)

island_data <- MadIsland::extract_species(
  checklist_file_name = "vm_checklist.csv",
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

# add Chaerephon species as separate colonisation
Chaerephon_stem_age <- list()
for (i in seq_along(complete_multi_phylods)) {
  Chaerephon_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Chaerephon",
    phylod = complete_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Chaerephon as an stem age max age given the stem age in the tree
multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
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
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_missing_species,
  num_missing_species = 2,
  species_to_add_to = "Hipposideros_commersoni"
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
  num_mainland_species = 100
)

# save the main data outputs
# 1) the multi_island_tbl
saveRDS(
  object = multi_island_tbl_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "vm_data",
    "vm_it_complete_ds_asr.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "vm_data",
    "vm_ddt_complete_ds_asr.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "vm_data",
    "vm_ddl_complete_ds_asr.rds"
  )
)
