library(MadIsland)

# load madagascar birds species data table
data("madagascar_birds_dna_ds", package = "MadIsland")

# check that the data has loaded correctly and that it has the correct data
head(madagascar_birds_dna_ds)
all(
  colnames(madagascar_birds_dna_ds) ==
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
  dna_or_complete = "DNA"
)

# look at missing species to check
missing_bird_species

# load the DNA-only trees
bird_posterior_dna <- ape::read.nexus(
  file = system.file(
    "extdata", "phylos", "Jetz_dna_posterior_100.nex",
    package = "MadIsland"
  )
)

#delete
bird_posterior_dna <- bird_posterior_dna[1:3]

# convert trees to phylo4 objects
dna_phylos <- lapply(bird_posterior_dna, phylobase::phylo4)

# remove phylo objects to free up some memory
rm(bird_posterior_dna)
gc()

# create endemicity status data frame
endemicity_status_dna <- lapply(
  dna_phylos,
  DAISIEprep::create_endemicity_status,
  island_species = madagascar_birds_dna_ds
)

# combine tree and endemicity status
dna_multi_phylods <- mapply(
  phylobase::phylo4d,
  dna_phylos,
  endemicity_status_dna
)

# reconstruct geographic ancestral states for extraction with asr
dna_multi_phylods <- lapply(
  dna_multi_phylods,
  DAISIEprep::add_asr_node_states,
  asr_method = "mk",
  tie_preference = "mainland"
)

# extract island community using asr algorithm
multi_island_tbl_dna <- DAISIEprep::multi_extract_island_species(
  multi_phylod = dna_multi_phylods,
  extraction_method = "asr",
  verbose = TRUE
)

# determine which island clade the missing species should be assigned to
missing_genus_dna <- lapply(
  multi_island_tbl_dna,
  unique_missing_species
)

# add missing species that match genera found in the island tbl
multi_island_tbl_dna <- mapply(
  add_phylo_missing_species,
  missing_genus_dna,
  multi_island_tbl_dna,
  missing_species = list(missing_bird_species)
)

# remove missing species that have already been inserted into the island tbl
no_phylo_missing_bird_species_dna <- lapply(
  missing_genus_dna,
  rm_phylo_missing_species,
  missing_species = missing_bird_species
)

# check that all the missing species that have not already been assigned are the
# same between different trees in the posterior
sapply(
  list(
    no_phylo_missing_bird_species_dna[[2]]$clade_name,
    no_phylo_missing_bird_species_dna[[3]]$clade_name
  ), identical,
  no_phylo_missing_bird_species_dna[[1]]$clade_name
)

# check which missing species that are not already assigned have stem ages in
# the tree, when no stem is found only one tree needs to be checked as each
# tree in the posterior contains the same species and just differs in branch
# lengths and topology, when the stem age is found, a stem age from each tree is
# required
Accipiter_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Accipiter_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Accipiter",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Actophilornis_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Actophilornis_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Actophilornis",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Aepyornis",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Alopochen_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Alopochen_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Alopochen",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Amaurornis_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Amaurornis_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Amaurornis",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Anastomus",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Aquila_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Aquila_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Aquila",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Aviceda_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Aviceda_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Aviceda",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Aythya_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Aythya_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Aythya",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Bradypterus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Bradypterus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Bradypterus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Buteo_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Buteo_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Buteo",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Calicalicus",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

DAISIEprep::extract_stem_age(
  genus_name = "Canirallus",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

DAISIEprep::extract_stem_age(
  genus_name = "Centrornis",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Circus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Circus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Circus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Dryolimnas",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Egretta_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Egretta_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Egretta",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Euryceros",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

DAISIEprep::extract_stem_age(
  genus_name = "Falculea",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Gallinago_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Gallinago_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Gallinago",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Hovacrex",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

DAISIEprep::extract_stem_age(
  genus_name = "Hypositta",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

DAISIEprep::extract_stem_age(
  genus_name = "Leptopterus",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Leptosomus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Leptosomus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Leptosomus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Lophotibis",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

DAISIEprep::extract_stem_age(
  genus_name = "Mentocrex",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Mesitornis_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Mesitornis_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Mesitornis",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Mirafra_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Mirafra_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Mirafra",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Monias_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Monias_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Monias",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Mullerornis",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Nettapus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Nettapus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Nettapus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Newtonia",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Ninox_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Ninox_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Ninox",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Oriolia",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Phalacrocorax_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Phalacrocorax_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Phalacrocorax",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Ploceus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Ploceus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Ploceus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Polyboroides_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Polyboroides_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Polyboroides",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Pterocles_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Pterocles_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Pterocles",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Rallus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Rallus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Rallus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Randia",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Sarothrura_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Sarothrura_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Sarothrura",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Schetba",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Scopus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Scopus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Scopus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Stephanoaetus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Stephanoaetus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Stephanoaetus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Tachybaptus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Tachybaptus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Tachybaptus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Terpsiphone_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Terpsiphone_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Terpsiphone",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Threskiornis_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Threskiornis_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Threskiornis",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Turnix_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Turnix_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Turnix",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Tylas",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

Upupa_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Upupa_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Upupa",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

Vanellus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Vanellus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Vanellus",
    phylod = dna_multi_phylods[[i]],
    extraction_method = "asr"
  )
}

DAISIEprep::extract_stem_age(
  genus_name = "Vorombe",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

DAISIEprep::extract_stem_age(
  genus_name = "Zoonavena",
  phylod = dna_multi_phylods[[1]],
  extraction_method = "asr"
)

# add the Accipiter as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Accipiter_francesiae"),
  status = list("endemic"),
  missing_species = list(2),
  branching_times = Accipiter_stem_age,
  min_age = list(NA),
  species = list(c(
    "Accipiter_francesiae",
    "Accipiter_henstii",
    "Accipiter_madagascariensis"
  ))
)

# add the Actophilornis as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Actophilornis_albinucha"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Actophilornis_stem_age,
  min_age = list(NA),
  species = list("Actophilornis_albinucha")
)

# add the Aepyornis as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
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
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Alopochen_sirabensis"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Alopochen_stem_age,
  min_age = list(NA),
  species = list("Alopochen_sirabensis")
)

# add the Amaurornis as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Amaurornis_olivieri"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Amaurornis_stem_age,
  min_age = list(NA),
  species = list("Amaurornis_olivieri")
)

# add the Anastomus as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Anastomus_lamelligerus",
  status = "nonendemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Anastomus_lamelligerus"
)

# add the Aquila as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Aquila_A"),
  status = list("endemic"),
  missing_species = list(1),
  branching_times = Aquila_stem_age,
  min_age = list(NA),
  species = list(c("Aquila_A", "Aquila_B"))
)

# add the Aviceda as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Aviceda_madagascariensis"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Aviceda_stem_age,
  min_age = list(NA),
  species = list("Aviceda_madagascariensis")
)

# add the Aythya as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Aythya_innotata"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Aythya_stem_age,
  min_age = list(NA),
  species = list("Aythya_innotata")
)

# add the Bradypterus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Bradypterus_seebohmi"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Bradypterus_stem_age,
  min_age = list(NA),
  species = list("Bradypterus_seebohmi")
)

# add the Buteo as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Buteo_brachypterus"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Buteo_stem_age,
  min_age = list(NA),
  species = list("Buteo_brachypterus")
)

# add the Calicalicus as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Calicalicus_madagascariensis",
  status = "endemic",
  missing_species = 1,
  branching_times = 88,
  min_age = NA,
  species = c(
    "Calicalicus_madagascariensis",
    "Calicalicus_rufocarpalis"
  )
)

# add the Canirallus as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Canirallus_kioloides",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Canirallus_kioloides"
)

# add the Centrornis as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Centrornis_majori",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Centrornis_majori"
)

# add the Circus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Circus_macrosceles"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Circus_stem_age,
  min_age = list(NA),
  species = list("Circus_macrosceles")
)

# add the Dryolimnas as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Dryolimnas_cuvieri",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Dryolimnas_cuvieri"
)

# add the Egretta as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Egretta_ardesiaca"),
  status = list("nonendemic"),
  missing_species = list(0),
  branching_times = Egretta_stem_age,
  min_age = list(NA),
  species = list("Egretta_ardesiaca")
)

# add the Euryceros as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Euryceros_prevostii",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Euryceros_prevostii"
)

# add the Falculea as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Falculea_palliata",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Falculea_palliata"
)

# add the Gallinago as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Gallinago_macrodactyla"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Gallinago_stem_age,
  min_age = list(NA),
  species = list("Gallinago_macrodactyla")
)

# add the Hovacrex as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Hovacrex_roberti",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Hovacrex_roberti"
)

# add the Hypositta as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Hypositta_corallirostris",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Hypositta_corallirostris"
)

# add the Leptopterus as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Leptopterus_chabert",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Leptopterus_chabert"
)

# add the Leptosomus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Leptosomus_discolor"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Leptosomus_stem_age,
  min_age = list(NA),
  species = list("Leptosomus_discolor")
)

# add the Lophotibis as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Lophotibis_cristata",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Lophotibis_cristata"
)

# add the Mentocrex as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Mentocrex_beankaensis",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Mentocrex_beankaensis"
)

# add the Mesitornis as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Mesitornis_unicolor"),
  status = list("endemic"),
  missing_species = list(1),
  branching_times = Mesitornis_stem_age,
  min_age = list(NA),
  species = list(c(
    "Mesitornis_unicolor",
    "Mesitornis_variegatus"
  ))
)

# add the Mirafra as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Mirafra_hova"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Mirafra_stem_age,
  min_age = list(NA),
  species = list("Mirafra_hova")
)

# add the Monias as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Monias_benschi"),
  status = list("endemic"),
  missing_species = list(1),
  branching_times = Monias_stem_age,
  min_age = list(NA),
  species = list(c("Monias_benschi", "Monias_A"))
)

# add the Mullerornis as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
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

# add the Nettapus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Nettapus_auritus"),
  status = list("nonendemic"),
  missing_species = list(0),
  branching_times = Nettapus_stem_age,
  min_age = list(NA),
  species = list("Nettapus_auritus")
)

# add the Newtonia as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Newtonia_amphichroa",
  status = "endemic",
  missing_species = 3,
  branching_times = 88,
  min_age = NA,
  species = c(
    "Newtonia_amphichroa",
    "Newtonia_archboldi",
    "Newtonia_brunneicauda",
    "Newtonia_fanovanae"
  )
)

# add the Ninox as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Ninox_superciliaris"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Ninox_stem_age,
  min_age = list(NA),
  species = list("Ninox_superciliaris")
)

# add the Oriolia as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Oriolia_bernieri",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Oriolia_bernieri"
)

# Phalacrocorax are counted as two missing species, however, there is one
# endemic species (Phalacrocorax_A) and one non-endemic species
# (Phalacrocorax_africanus). Therefore, to incorporate these as two separate
# island colonisations we input them into the data separately in two steps

# add the Phalacrocorax non-endemic species as an stem age max age given the
# stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Phalacrocorax_africanus"),
  status = list("nonendemic"),
  missing_species = list(0),
  branching_times = Phalacrocorax_stem_age,
  min_age = list(NA),
  species = list("Phalacrocorax_africanus")
)

# add the Phalacrocorax endemic species as an stem age max age given the stem
# age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Phalacrocorax_A"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Phalacrocorax_stem_age,
  min_age = list(NA),
  species = list("Phalacrocorax_A")
)

# add the Ploceus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Ploceus_nelicourvi"),
  status = list("endemic"),
  missing_species = list(1),
  branching_times = Ploceus_stem_age,
  min_age = list(NA),
  species = list(c(
    "Ploceus_nelicourvi",
    "Ploceus_sakalava"
  ))
)

# add the Polyboroides as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Polyboroides_radiatus"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Polyboroides_stem_age,
  min_age = list(NA),
  species = list("Polyboroides_radiatus")
)

# add the Pterocles as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Pterocles_personatus"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Pterocles_stem_age,
  min_age = list(NA),
  species = list("Pterocles_personatus")
)

# add the Rallus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Rallus_madagascariensis"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Rallus_stem_age,
  min_age = list(NA),
  species = list("Rallus_madagascariensis")
)

# add the Randia as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Randia_pseudozosterops",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Randia_pseudozosterops"
)

# add the Sarothrura as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Sarothrura_insularis"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Sarothrura_stem_age,
  min_age = list(NA),
  species = list(c(
    "Sarothrura_insularis",
    "Sarothrura_watersi"
  ))
)

# add the Schetba as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Schetba_rufa",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Schetba_rufa"
)

# add the Scopus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Scopus_umbretta"),
  status = list("nonendemic"),
  missing_species = list(0),
  branching_times = Scopus_stem_age,
  min_age = list(NA),
  species = list("Scopus_umbretta")
)

# add the Stephanoaetus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Stephanoaetus_mahery"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Stephanoaetus_stem_age,
  min_age = list(NA),
  species = list("Stephanoaetus_mahery")
)

# Tachybaptus already has a non-endemic species in the island_tbl, the two
# missing species (Tachybaptus_rufolavatus and Tachybaptus_pelzelnii) are
# endemic and so are added as a separate colonist

# add the Tachybaptus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Tachybaptus_rufolavatus"),
  status = list("endemic"),
  missing_species = list(1),
  branching_times = Tachybaptus_stem_age,
  min_age = list(NA),
  species = list(c(
    "Tachybaptus_rufolavatus",
    "Tachybaptus_pelzelnii"
  ))
)

# add the Terpsiphone as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Terpsiphone_mutata"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Terpsiphone_stem_age,
  min_age = list(NA),
  species = list("Terpsiphone_mutata")
)

# add the Threskiornis as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Threskiornis_bernieri"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Threskiornis_stem_age,
  min_age = list(NA),
  species = list("Threskiornis_bernieri")
)

# add the Turnix as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Turnix_nigricollis"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Turnix_stem_age,
  min_age = list(NA),
  species = list("Turnix_nigricollis")
)

# add the Tylas as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Tylas_eduardi",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Tylas_eduardi"
)

# add the Upupa as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Upupa_epops"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Upupa_stem_age,
  min_age = list(NA),
  species = list("Upupa_epops")
)

# add the Vanellus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Vanellus_madagascariensis"),
  status = list("endemic"),
  missing_species = list(0),
  branching_times = Vanellus_stem_age,
  min_age = list(NA),
  species = list("Vanellus_madagascariensis")
)

# add the Vorombe as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Vorombe_titans",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Vorombe_titans"
)

# add the Zoonavena as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Zoonavena_grandidieri",
  status = "endemic",
  missing_species = 0,
  branching_times = 88,
  min_age = NA,
  species = "Zoonavena_grandidieri"
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
    "bird_data",
    "bird_island_tbl_dna_ds_asr.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "bird_data",
    "bird_daisie_datatable_dna_ds_asr.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_dna,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "bird_data",
    "bird_daisie_data_list_dna_ds_asr.rds"
  )
)
