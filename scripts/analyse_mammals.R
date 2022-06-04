# load madagascar mammals species data table
data("madagascar_mammals", package = "MadIsland")

# get missing species
mammal_checklist <- read_checklist(file_name = "mammal_checklist.csv")
missing_mammal_species <- count_missing_species(checklist = mammal_checklist)

# load the DNA only and complete trees
mammal_posterior_dna <- ape::read.nexus(
  file = system.file(
    "extdata/Upham_dna_posterior_100.nex",
    package = "MadIsland"
  )
)

mammal_posterior_complete <- ape::read.nexus(
  file = system.file(
    "extdata/Upham_complete_posterior_100.nex",
    package = "MadIsland"
  )
)

#delete
mammal_posterior_dna <- mammal_posterior_dna[1:3]
mammal_posterior_complete <- mammal_posterior_complete[1:3]

# convert trees to phylo4 objects
dna_phylos <- lapply(mammal_posterior_dna, phylobase::phylo4)
complete_phylos <- lapply(mammal_posterior_complete, phylobase::phylo4)

# remove phylo objects to free up some memory
rm(mammal_posterior_dna)
rm(mammal_posterior_complete)
gc()

# create endemicity status data frame
endemicity_status_dna <- lapply(
  dna_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_mammals
)

endemicity_status_complete <- lapply(
  complete_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_mammals
)

# ensure dna_phylos and complete_phylos are the same length
length(dna_phylos) == length(complete_phylos)

# combine tree and endemicity status
dna_multi_phylods <- list()
complete_multi_phylods <- list()
for (i in seq_along(dna_phylos)) {
  message("Converting phylo ", i, " of ", length(dna_phylos))
  dna_multi_phylods[[i]] <- phylobase::phylo4d(
    dna_phylos[[i]],
    endemicity_status_dna[[i]]
  )
  complete_multi_phylods[[i]] <- phylobase::phylo4d(
    complete_phylos[[i]],
    endemicity_status_complete[[i]]
  )
}

# extract island community using min algorithm
multi_island_tbl_dna_unique <- DAISIEprep::multi_extract_island_species(
  multi_phylod = dna_multi_phylods,
  extraction_method = "min",
  verbose = TRUE
)

multi_island_tbl_dna <- DAISIEprep::multi_extract_island_species(
  multi_phylod = dna_multi_phylods,
  extraction_method = "min",
  verbose = TRUE,
  unique_clade_name = FALSE
)

multi_island_tbl_complete_unique <- DAISIEprep::multi_extract_island_species(
  multi_phylod = complete_multi_phylods,
  extraction_method = "min",
  verbose = TRUE
)

multi_island_tbl_complete <- DAISIEprep::multi_extract_island_species(
  multi_phylod = complete_multi_phylods,
  extraction_method = "min",
  verbose = TRUE,
  unique_clade_name = FALSE
)

# add missing species to each island table
island_tbl_unique <- DAISIEprep::get_island_tbl(multi_island_tbl_dna_unique[[1]])
island_tbl_unique_clade_name <- island_tbl_unique$clade_name
missing_species_clade_name <- missing_mammal_species$clade_name
island_tbl_split_names <- strsplit(x = island_tbl_unique_clade_name, split = "_")
island_tbl_genus_names <- sapply(island_tbl_split_names, "[[", 1)
which_missing_species <- which(
  missing_species_clade_name %in% island_tbl_genus_names
)
island_missing_species <- missing_mammal_species[which_missing_species, ]

# add missing species to each island table
island_tbl <- DAISIEprep::get_island_tbl(multi_island_tbl_dna[[1]])
island_tbl_clade_name <- island_tbl$clade_name
missing_species_clade_name <- missing_mammal_species$clade_name
island_tbl_split_names <- strsplit(x = island_tbl_clade_name, split = "_")
island_tbl_genus_names <- sapply(island_tbl_split_names, "[[", 1)
island_missing_species <- missing_mammal_species[which(missing_species_clade_name %in% island_tbl_genus_names), ]

island_tbl <- DAISIEprep::add_missing_species(
  island_tbl = multi_island_tbl_dna_unique[[1]],
  missing_species_df = island_missing_species
)

# convert to daisie data table
daisie_datatable_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::as_daisie_datatable,
  island_age = 88
)

daisie_datatable_complete <- lapply(
  multi_island_tbl_complete,
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

daisie_data_list_complete <- lapply(
  daisie_datatable_complete,
  DAISIEprep::create_daisie_data,
  island_age = 88,
  num_mainland_species = 1000
)


# ensure dna data list and complete data list are the same length
length(daisie_data_list_dna) == length(daisie_data_list_complete)

# run DAISIE model
ml_dna <- list()
ml_complete <- list()
for (i in seq_along(dna_phylos)) {
  message(
    "Fitting DAISIE model to data set ", i, " of ", length(daisie_data_list_dna)
  )

  ml_dna[[i]] <- DAISIE::DAISIE_ML_CS(
    datalist = daisie_data_list_dna[[i]],
    initparsopt = c(1, 1, 200, 0.1, 1),
    idparsopt = 1:5,
    parsfix = NULL,
    idparsfix = NULL,
    ddmodel = 11,
    jitter = 1e-5
  )

  ml_complete[[i]] <- DAISIE::DAISIE_ML_CS(
    datalist = daisie_data_list_complete[[i]],
    initparsopt = c(1, 1, 200, 0.1, 1),
    idparsopt = 1:5,
    parsfix = NULL,
    idparsfix = NULL,
    ddmodel = 11,
    jitter = 1e-5
  )
}
