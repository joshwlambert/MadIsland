library(MadIsland)
# load ape to prevent class conversion issues, not 100% sure why but could be
# class-specific subsetting that is exported in ape
library(ape)

island_data <- MadIsland::extract_species(
  checklist_file_name = "squa_checklist.csv",
  phylo_file_name = "Tonini_dna_posterior_100.rds",
  dna_or_complete = "DNA",
  daisie_status = TRUE,
  extraction_method = "asr",
  rate_model = "ARD"
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

# add the Brygophis as a missing species of the clade with
# Thamnosophis_infrasignatus in it as it is a member of the Pseudoxyrhophiidae
# radiation on Madagascar
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_missing_species,
  num_missing_species = 1,
  species_to_add_to = "Thamnosophis_infrasignatus"
)

# add the Pararhadinaea as a missing species of the clade with
# Thamnosophis_infrasignatus in it as it is a member of the Pseudoxyrhophiidae
# radiation on Madagascar
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_missing_species,
  num_missing_species = 1,
  species_to_add_to = "Thamnosophis_infrasignatus"
)

# add the Sirenoscincus as a missing species of the clade with
# Voeltzkowia_petiti in it as it is a member of the  Voeltzkowia-Sirenoscincus
# radiation on Madagascar
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_missing_species,
  num_missing_species = 2,
  species_to_add_to = "Voeltzkowia_petiti"
)

# Lemuriatyphlops is added as a separate colonist from Madatyphlops but they are
# synonyms and are of the same genus, therefore we remove Lemuriatyphlops
# as a separate colonist and add the two species as missing species to
# Madatyphlops (Madatyphlops_rajeryi)
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::rm_island_colonist,
  clade_name = "Lemuriatyphlops"
)

# add Lemuriatyphlops species to Madatyphlops
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_missing_species,
  num_missing_species = 3,
  species_to_add_to = "Madatyphlops_rajeryi"
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
  num_mainland_species = 600
)

# save the main data outputs
# 1) the multi_island_tbl
saveRDS(
  object = multi_island_tbl_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "squa_data",
    "squa_it_dna_ds_asr.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "squa_data",
    "squa_ddt_dna_ds_asr.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "squa_data",
    "squa_ddl_dna_ds_asr.rds"
  )
)
