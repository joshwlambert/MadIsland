library(MadIsland)

# load madagascar birds species data table
data("madagascar_birds_complete", package = "MadIsland")

# check that the data has loaded correctly and that it has the correct data
head(madagascar_birds_complete)
all(
  colnames(madagascar_birds_complete) ==
    c("tip_labels", "tip_endemicity_status")
)

# load the full raw data checklist of bird species of madagascar
bird_checklist <- read_checklist(file_name = "bird_checklist.csv")

# check that the data has loaded correctly and that it has the correct data
head(bird_checklist)
all(colnames(bird_checklist) == c(
  "Genus", "Species", "Subspecies", "Family", "Order", "Common_Name",
  "Name_In_Tree", "Sampled", "DNA_In_Tree", "Extinct_Extant",
  "Status_Species", "DAISIE_Status_Species", "Remove_Species"
))

# count the number of missing species for each genus
missing_bird_species <- count_missing_species(
  checklist = bird_checklist,
  dna_or_complete = "complete"
)

# look at missing species to check
missing_bird_species

# load the complete trees
bird_posterior_complete <- ape::read.nexus(
  file = system.file(
    "extdata", "phylos", "Jetz_complete_posterior_100.nex",
    package = "MadIsland"
  )
)

#delete
bird_posterior_complete <- bird_posterior_complete[1:3]

# convert trees to phylo4 objects
complete_phylos <- lapply(bird_posterior_complete, phylobase::phylo4)

# remove phylo objects to free up some memory
rm(bird_posterior_complete)
gc()

# create endemicity status data frame
endemicity_status_complete <- lapply(
  complete_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_birds_complete
)

# combine tree and endemicity status
complete_multi_phylods <- mapply(
  phylobase::phylo4d,
  complete_phylos,
  endemicity_status_complete
)

# extract island community using min algorithm
multi_island_tbl_complete <- DAISIEprep::multi_extract_island_species(
  multi_phylod = complete_multi_phylods,
  extraction_method = "min",
  verbose = TRUE
)

# determine which island clade the missing species should be assigned to
missing_genus_complete <- lapply(
  multi_island_tbl_complete,
  unique_missing_species
)

# add missing species that match genera found in the island tbl
multi_island_tbl_complete <- mapply(
  add_phylo_missing_species,
  missing_genus_complete,
  multi_island_tbl_complete,
  missing_species = list(missing_bird_species)
)

# remove missing species that have already been inserted into the island tbl
no_phylo_missing_bird_species_complete <- lapply(
  missing_genus_complete,
  rm_phylo_missing_species,
  missing_species = missing_bird_species
)

# check that all the missing species that have not already been assigned are the
# same between different trees in the posterior
sapply(
  list(
    no_phylo_missing_bird_species_complete[[2]]$clade_name,
    no_phylo_missing_bird_species_complete[[3]]$clade_name
  ), identical,
  no_phylo_missing_bird_species_complete[[1]]$clade_name
)

# check which missing species that are not already assigned have stem ages in
# the tree, when no stem is found only one tree needs to be checked as each
# tree in the posterior contains the same species and just differs in branch
# lengths and topology, when the stem age is found, a stem age from each tree is
# required
DAISIEprep::extract_stem_age(
  genus_name = "Aepyornis",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

Alopochen_stem_age <- list()
for (i in seq_along(complete_multi_phylods)) {
  Alopochen_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Alopochen",
    phylod = complete_multi_phylods[[i]],
    extraction_method = "min"
  )
}

Aquila_stem_age <- list()
for (i in seq_along(complete_multi_phylods)) {
  Aquila_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Aquila",
    phylod = complete_multi_phylods[[i]],
    extraction_method = "min"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Centrornis",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Hovacrex",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Mentocrex",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

DAISIEprep::extract_stem_age(
  genus_name = "Mullerornis",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

Stephanoaetus_stem_age <- list()
for (i in seq_along(complete_multi_phylods)) {
  Stephanoaetus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Stephanoaetus",
    phylod = complete_multi_phylods[[i]],
    extraction_method = "min"
  )
}

Vanellus_stem_age <- list()
for (i in seq_along(complete_multi_phylods)) {
  Vanellus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Vanellus",
    phylod = complete_multi_phylods[[i]],
    extraction_method = "min"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Vorombe",
  phylod = complete_multi_phylods[[1]],
  extraction_method = "min"
)

# add the Aepyornis as an island age max age as there is no stem age in the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Aepyornis_gracilis",
  status = "endemic",
  missing_species = 3,
  branching_times = 88,
  min_age = NA,
  species = c(
    "Aepyornis_gracilis",
    "Aepyornis_hildebrandti",
    "Aepyornis_maximus",
    "Aepyornis_medius"
  )
)

# add the Alopochen as an stem age max age given the stem age in the tree
new_multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
  clade_name = list("Alopochen_sirabensis"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Alopochen_stem_age,
  min_age = list(NA),
  species = list("Alopochen_sirabensis")
)

# add the Aquila as an stem age max age given the stem age in the tree
multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
  clade_name = list("Aquila_A"),
  status = list("endemic"),
  missing_species = list(1),
  branching_times = Aquila_stem_age,
  min_age = list(NA),
  species = list(c("Aquila_A", "Aquila_B"))
)

# add the Centrornis as an island age max age as there is no stem age in the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Centrornis_majori",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Centrornis	majori"
)

# add the Hovacrex as an island age max age as there is no stem age in the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Hovacrex_roberti",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Hovacrex_roberti"
)

# add the Mentocrex as an island age max age as there is no stem age in the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Mentocrex_beankaensis",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Mentocrex_beankaensis"
)

# add the Mullerornis as an island age max age as there is no stem age in the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Mullerornis_agilis",
  status = "endemic",
  missing_species = 3,
  branching_times = 88,
  min_age = NA,
  species = c(
    "Mullerornis_agilis",
    "Mullerornis_betsilei",
    "Mullerornis_grandis",
    "Mullerornis_rudis"
  )
)

# add the Stephanoaetus as an stem age max age given the stem age in the tree
multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
  clade_name = list("Stephanoaetus_mahery"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Stephanoaetus_stem_age,
  min_age = list(NA),
  species = list("Stephanoaetus_mahery")
)

# add the Vanellus as an stem age max age given the stem age in the tree
multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
  clade_name = list("Vanellus_madagascariensis"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Vanellus_stem_age,
  min_age = list(NA),
  species = list("Vanellus_madagascariensis")
)

# add the Vorombe as an island age max age as there is no stem age in the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_island_colonist,
  clade_name = "Vorombe_titans",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Vorombe_titans"
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
    "bird_island_tbl_complete.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "bird_daisie_datatable_complete.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "bird_daisie_data_list_complete.rds"
  )
)
