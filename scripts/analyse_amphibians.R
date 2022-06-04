# load madagascar amphibians species data table
data("madagascar_amphibians", package = "MadIsland")

# check that the data has loaded correctly and that it has the correct data
head(madagascar_amphibians)
all(colnames(madagascar_amphibians) == c("tip_labels", "tip_endemicity_status"))

# load the full raw data checklist of amphibian species of madagascar
amphibian_checklist <- read_checklist(file_name = "amphibian_checklist.csv")

# check that the data has loaded correctly and that it has the correct data
head(amphibian_checklist)
all(colnames(amphibian_checklist) == c(
  "Genus", "Species", "Subspecies", "Family", "Order", "Common_Name",
  "Our_Name", "Name_In_Tree", "Sampled", "DNA_In_Tree", "Extinct_Extant",
  "Status_Species", "DAISIE_Species_Status", "Remove_Species"
))

# count the number of missing species for each genus
missing_amphibian_species <- count_missing_species(
  checklist = amphibian_checklist
)

# load the complete trees
amphibian_posterior_complete <- ape::read.nexus(
  file = system.file(
    "extdata/Jetz_Pyron_complete_posterior_100.nex",
    package = "MadIsland"
  )
)

#delete
amphibian_posterior_complete <- amphibian_posterior_complete[1:3]

# convert trees to phylo4 objects
complete_phylos <- lapply(amphibian_posterior_complete, phylobase::phylo4)

# remove phylo objects to free up some memory
rm(amphibian_posterior_complete)
gc()

# create endemicity status data frame
endemicity_status_complete <- lapply(
  complete_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_amphibians
)

# combine tree and endemicity status
complete_multi_phylods <- list()
for (i in seq_along(complete_phylos)) {
  message("Converting phylo ", i, " of ", length(complete_phylos))
  complete_multi_phylods[[i]] <- phylobase::phylo4d(
    complete_phylos[[i]],
    endemicity_status_complete[[i]]
  )
}

# extract island community using min algorithm
multi_island_tbl_complete <- DAISIEprep::multi_extract_island_species(
  multi_phylod = complete_multi_phylods,
  extraction_method = "min",
  verbose = TRUE
)

# consider deleting
# extract island community again but this time set unique_clade_name = FALSE
# multi_island_tbl_complete_unique <- DAISIEprep::multi_extract_island_species(
#   multi_phylod = complete_multi_phylods,
#   extraction_method = "min",
#   verbose = TRUE,
#   unique_clade_name = FALSE
# )

# add missing species to each island table
island_tbl <- DAISIEprep::get_island_tbl(multi_island_tbl_complete[[1]])
island_tbl_species <- island_tbl$species
island_tbl_split_names <- lapply(island_tbl$species, strsplit, split = "_")
island_tbl_genus_names <- lapply(island_tbl_split_names, function(x) {
  lapply(x, "[[", 1)
})
island_tbl_genus_names <- lapply(island_tbl_genus_names, unlist)
for (i in seq_along(island_tbl_genus_names)) {
  which_species <- which(
    missing_amphibian_species$clade_name %in% island_tbl_genus_names[[i]]
  )

  # if that clade contains a genus that has missing species then add missing
  # species to island_tbl
  if (length(which_species) > 0) {
    phylo_missing_species <- missing_amphibian_species[which_species, ]

    # sum up number of missing species if there are multiple genera in a clade
    phylo_missing_species <- data.frame(
      clade_name = multi_island_tbl_complete[[1]]@island_tbl$clade_name[i],
      missing_species = sum(phylo_missing_species$missing_species)
    )

    # add the number of missing species to the island tbl for those that have been
    # extracted already
    multi_island_tbl_complete[[1]] <- DAISIEprep::add_missing_species(
      island_tbl = multi_island_tbl_complete[[1]],
      missing_species_df = phylo_missing_species
    )
  }
}

# remove those missing species that have already been inserted into the island
# tbl
no_phylo_missing_species <- missing_amphibian_species[-which_missing_species, ]

anodonthyla_stem_age <- DAISIEprep::extract_stem_age(
  genus_name = "Anodonthyla",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

cophyla_stem_age <- DAISIEprep::extract_stem_age(
  genus_name = "Cophyla",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

guibemantis_stem_age <- DAISIEprep::extract_stem_age(
  genus_name = "Guibemantis",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

mini_stem_age <- DAISIEprep::extract_stem_age(
  genus_name = "Mini",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

platypelis_stem_age <- DAISIEprep::extract_stem_age(
  genus_name = "Platypelis",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

plethodontohyla_stem_age <- DAISIEprep::extract_stem_age(
  genus_name = "Plethodontohyla",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

rhombophryne_stem_age <- DAISIEprep::extract_stem_age(
  genus_name = "Rhombophryne",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

stumpffia_stem_age <- DAISIEprep::extract_stem_age(
  genus_name = "Stumpffia",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)
