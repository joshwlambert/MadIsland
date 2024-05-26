library(MadIsland)
# load ape to prevent class conversion issues, not 100% sure why but could be
# class-specific subsetting that is exported in ape
library(ape)

island_data <- MadIsland::extract_species(
  checklist_file_name = "bird_checklist.csv",
  phylo_file_name = "Jetz_dna_posterior_100.rds",
  dna_or_complete = "DNA",
  daisie_status = TRUE,
  extraction_method = "asr",
  rate_model = "ER"
)

multi_island_tbl_dna <- island_data$multi_island_tbl
no_island_tbl_missing_species <- island_data$no_island_tbl_missing_species
dna_multi_phylods <- island_data$phylods

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
    stem = "genus"
  )
}

# add the Accipiter as three separate colonisation as an stem age max age given
# the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Accipiter_francesiae"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Accipiter_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Accipiter_francesiae"),
  clade_type = list(1)
)

multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Accipiter_henstii"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Accipiter_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Accipiter_henstii"),
  clade_type = list(1)
)

multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Accipiter_madagascariensis"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Accipiter_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Accipiter_madagascariensis"),
  clade_type = list(1)
)

Actophilornis_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Actophilornis_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Actophilornis",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Actophilornis as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Actophilornis_albinucha"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Actophilornis_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Actophilornis_albinucha"),
  clade_type = list(1)
)

# extinct elephant bird species (Aepyornis, Mullerornis, Vorombe) grouped as a
# single island colonist
DAISIEprep::extract_stem_age(
  genus_name = "Aepyornis",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

DAISIEprep::extract_stem_age(
  genus_name = "Mullerornis",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

DAISIEprep::extract_stem_age(
  genus_name = "Vorombe",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

# add the elephant birds (Aepyornis, Mullerornis and  Vorombe) as an island age
# max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "elephant_birds",
  status = "endemic",
  missing_species = 8,
  col_time = NA_real_,
  col_max_age = TRUE,
  branching_times = NA_real_,
  min_age = NA_real_,
  species = c(
    "Aepyornis_gracilis",
    "Aepyornis_hildebrandti",
    "Aepyornis_maximus",
    "Aepyornis_medius",
    "Mullerornis_agilis",
    "Mullerornis_betsilei",
    "Mullerornis_grandis",
    "Mullerornis_rudis",
    "Vorombe_titans"
  ),
  clade_type = 1
)

Alopochen_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Alopochen_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Alopochen",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Alopochen as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Alopochen_sirabensis"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Alopochen_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Alopochen_sirabensis"),
  clade_type = list(1)
)

# add the missing endemic Amaurornis (Zapornia olivieri) species as an island
# age max age. The other Malagasy species (Zapornia pusilla/ Porzana pusilla)
# is a singleton non-endemic, so it cannot be added to that one. A stem age is
# possible from the tree (Amaurornis), but there have been generic
# rearrangements, with the Malagasy species now being Zapornia (no samples with
# this name on the tree). As it is unclear whether the Malagasy species is
# related to the Amaurornis on the tree, the stem age extracted is
# uninformative, so the island age is used over the stem age
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Amaurornis_olivieri",
  status = "endemic",
  missing_species = 0,
  col_time = NA_real_,
  col_max_age = TRUE,
  branching_times = NA_real_,
  min_age = NA_real_,
  species = "Amaurornis_olivieri",
  clade_type = 1
)

DAISIEprep::extract_stem_age(
  genus_name = "Anastomus",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

# add the Anastomus as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Anastomus_lamelligerus",
  status = "nonendemic",
  missing_species = 0,
  col_time = NA_real_,
  col_max_age = TRUE,
  branching_times = NA_real_,
  min_age = NA_real_,
  species = "Anastomus_lamelligerus",
  clade_type = 1
)

# Apus
Apus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Apus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Apus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Apus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Apus_balstoni"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Apus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list(c("Apus_balstoni")),
  clade_type = list(1)
)

Aquila_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Aquila_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Aquila",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Aquila as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Aquila_A"),
  status = list("endemic"),
  missing_species = list(1),
  col_time = Aquila_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list(c("Aquila_A", "Aquila_B")),
  clade_type = list(1)
)

# Ardea
Ardea_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Ardea_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Ardea",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Ardea endemic singleton as an stem age max age given the stem age in
# the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Ardea_humbloti"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Ardea_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list(c("Ardea_humbloti")),
  clade_type = list(1)
)

# add the Ardea non-endemic singleton as an stem age max age given the stem age
# in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Ardea_purpurea"),
  status = list("nonendemic"),
  missing_species = list(0),
  col_time = Ardea_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list(c("Ardea_purpurea")),
  clade_type = list(1)
)

# Asio
Asio_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Asio_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Asio",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Asio as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Asio_madagascariensis"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Asio_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Asio_madagascariensis"),
  clade_type = list(1)
)


Aviceda_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Aviceda_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Aviceda",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Aviceda as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Aviceda_madagascariensis"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Aviceda_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Aviceda_madagascariensis"),
  clade_type = list(1)
)

Aythya_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Aythya_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Aythya",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Aythya as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Aythya_innotata"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Aythya_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Aythya_innotata"),
  clade_type = list(1)
)

# add the Bradypterus as a missing species of the clade with
# Dromaeocercus_brunneus in it as it is the same genus but have different names
# on the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_missing_species,
  num_missing_species = 1,
  species_to_add_to = "Dromaeocercus_brunneus"
)

Buteo_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Buteo_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Buteo",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Buteo as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Buteo_brachypterus"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Buteo_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Buteo_brachypterus"),
  clade_type = list(1)
)

# add the Vangas (Artamella, Calicalicus, Cyanolanius, Euryceros, Falculea,
# Hypositta, Leptopterus, Mystacornis, Newtonia, Oriolia, Pseudobias, Schetba,
# Tylas, Vanga) as a missing species of the clade with
# Vanga_curvirostris as they are an endemic radiation from a single colonist
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_missing_species,
  num_missing_species = 13,
  species_to_add_to = "Vanga_curvirostris"
)

# Canirallus and Mentocrex are the same colonist of the same genus, but
# Canirallus is the old taxonomy
DAISIEprep::extract_stem_age(
  genus_name = "Canirallus",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

DAISIEprep::extract_stem_age(
  genus_name = "Mentocrex",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

# add the Canirallus and Mentocrex as an island age max age as there is no stem
# age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Mentocrex_beankaensis",
  status = "endemic",
  missing_species = 1,
  col_time = NA_real_,
  col_max_age = TRUE,
  branching_times = NA_real_,
  min_age = NA_real_,
  species = c(
    "Canirallus_kioloides",
    "Mentocrex_beankaensis"
  ),
  clade_type = 1
)

DAISIEprep::extract_stem_age(
  genus_name = "Centrornis",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

# add the Centrornis as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Centrornis_majori",
  status = "endemic",
  missing_species = 0,
  col_time = NA_real_,
  col_max_age = TRUE,
  branching_times = NA_real_,
  min_age = NA_real_,
  species = "Centrornis_majori",
  clade_type = 1
)

# Charadrius
Charadrius_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Charadrius_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Charadrius",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Charadrius non-endemic as an stem age max age given the stem age in
# the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Charadrius_pecuarius"),
  status = list("nonendemic"),
  missing_species = list(0),
  col_time = Charadrius_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Charadrius_pecuarius"),
  clade_type = list(1)
)

# add the second Charadrius non-endemic as an stem age max age given the stem
# age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Charadrius_tricollaris"),
  status = list("nonendemic"),
  missing_species = list(0),
  col_time = Charadrius_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Charadrius_tricollaris"),
  clade_type = list(1)
)

# add the Charadrius endemic as an stem age max age given the stem age in
# the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Charadrius_thoracicus"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Charadrius_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Charadrius_thoracicus"),
  clade_type = list(1)
)

Circus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Circus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Circus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Circus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Circus_macrosceles"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Circus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Circus_macrosceles"),
  clade_type = list(1)
)

# Coturnix
Coturnix_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Coturnix_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Coturnix",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Coturnix as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Coturnix_delegorguei"),
  status = list("nonendemic"),
  missing_species = list(0),
  col_time = Coturnix_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Coturnix_delegorguei"),
  clade_type = list(1)
)

# Cypsiurus
Cypsiurus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Cypsiurus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Cypsiurus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Cypsiurus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Cypsiurus_gracilis"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Cypsiurus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Cypsiurus_gracilis"),
  clade_type = list(1)
)

DAISIEprep::extract_stem_age(
  genus_name = "Dryolimnas",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

# add the Dryolimnas as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Dryolimnas_cuvieri",
  status = "endemic",
  missing_species = 0,
  col_time = NA_real_,
  col_max_age = TRUE,
  branching_times = NA_real_,
  min_age = NA_real_,
  species = "Dryolimnas_cuvieri",
  clade_type = 1
)

Egretta_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Egretta_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Egretta",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Egretta as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Egretta_ardesiaca"),
  status = list("nonendemic"),
  missing_species = list(0),
  col_time = Egretta_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Egretta_ardesiaca"),
  clade_type = list(1)
)

Gallinago_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Gallinago_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Gallinago",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Gallinago as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Gallinago_macrodactyla"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Gallinago_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Gallinago_macrodactyla"),
  clade_type = list(1)
)

DAISIEprep::extract_stem_age(
  genus_name = "Hovacrex",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

# add the Hovacrex as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Hovacrex_roberti",
  status = "endemic",
  missing_species = 0,
  col_time = NA_real_,
  col_max_age = TRUE,
  branching_times = NA_real_,
  min_age = NA_real_,
  species = "Hovacrex_roberti",
  clade_type = 1
)

DAISIEprep::extract_stem_age(
  genus_name = "Lophotibis",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

# add the Lophotibis as an island age max age as there is no stem age in the
# tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Lophotibis_cristata",
  status = "endemic",
  missing_species = 0,
  col_time = NA_real_,
  col_max_age = TRUE,
  branching_times = NA_real_,
  min_age = NA_real_,
  species = "Lophotibis_cristata",
  clade_type = 1
)

# stem age comes from Eremopterix as this missing species (Mirafra_hova) has
# been reclassified as Eremopterix
Mirafra_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Mirafra_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Eremopterix",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Mirafra as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Mirafra_hova"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Mirafra_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Mirafra_hova"),
  clade_type = list(1)
)

Nettapus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Nettapus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Nettapus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Nettapus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Nettapus_auritus"),
  status = list("nonendemic"),
  missing_species = list(0),
  col_time = Nettapus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Nettapus_auritus"),
  clade_type = list(1)
)

# the missing species (Ninox_superciliaris) has been reclassified in the genus
# Athene and this is where we extract the stem age from
Ninox_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Ninox_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Athene",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Ninox as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Ninox_superciliaris"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Ninox_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Ninox_superciliaris"),
  clade_type = list(1)
)

Phalacrocorax_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Phalacrocorax_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Phalacrocorax",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

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
  col_time = Phalacrocorax_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Phalacrocorax_africanus"),
  clade_type = list(1)
)

# add the Phalacrocorax endemic species as an stem age max age given the stem
# age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Phalacrocorax_A"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Phalacrocorax_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Phalacrocorax_A"),
  clade_type = list(1)
)

Ploceus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Ploceus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Ploceus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Ploceus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Ploceus_nelicourvi"),
  status = list("endemic"),
  missing_species = list(1),
  col_time = Ploceus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list(c(
    "Ploceus_nelicourvi",
    "Ploceus_sakalava"
  )),
  clade_type = list(1)
)

Polyboroides_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Polyboroides_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Polyboroides",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Polyboroides as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Polyboroides_radiatus"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Polyboroides_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Polyboroides_radiatus"),
  clade_type = list(1)
)

# Porphyrio
Porphyrio_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Porphyrio_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Porphyrio",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Porphyrio as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Porphyrio_alleni"),
  status = list("nonendemic"),
  missing_species = list(0),
  col_time = Porphyrio_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Porphyrio_alleni"),
  clade_type = list(1)
)

Pterocles_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Pterocles_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Pterocles",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Pterocles as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Pterocles_personatus"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Pterocles_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Pterocles_personatus"),
  clade_type = list(1)
)

Rallus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Rallus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Rallus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Rallus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Rallus_madagascariensis"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Rallus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Rallus_madagascariensis"),
  clade_type = list(1)
)

# add the missing Randia species of the Bernieridae endemic radiation
# (Bernieria, Crossleyia, Cryptosylvicola, Neomixis, Oxylabes, Randia,
# Thamnornis, Bernieria) which is composed of several genera as
# missing species of the clade with Oxylabes_madagascariensis. The tree does
# not always find a monophyletic clade, instead splitting Bernieria from the
# other genera, we decide to add all of the missing species to
# Oxylabes_madagascariensis as representative of the Bernieridae radiation.
# Species called Bernieria on the tree have been reclassified as Xanthomixis
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_missing_species,
  num_missing_species = 1,
  species_to_add_to = "Oxylabes_madagascariensis"
)

Sarothrura_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Sarothrura_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Sarothrura",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Sarothrura as separate stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Sarothrura_insularis"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Sarothrura_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Sarothrura_insularis"),
  clade_type = list(1)
)

multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Sarothrura_watersi"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Sarothrura_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Sarothrura_watersi"),
  clade_type = list(1)
)

Scopus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Scopus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Scopus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Scopus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Scopus_umbretta"),
  status = list("nonendemic"),
  missing_species = list(0),
  col_time = Scopus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Scopus_umbretta"),
  clade_type = list(1)
)

Stephanoaetus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Stephanoaetus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Stephanoaetus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Stephanoaetus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Stephanoaetus_mahery"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Stephanoaetus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Stephanoaetus_mahery"),
  clade_type = list(1)
)

Tachybaptus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Tachybaptus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Tachybaptus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# Tachybaptus already has a non-endemic species in the island_tbl, the two
# missing species (Tachybaptus_rufolavatus and Tachybaptus_pelzelnii) are
# endemic and so are added as a separate colonists to each other
# add the Tachybaptus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Tachybaptus_rufolavatus"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Tachybaptus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Tachybaptus_rufolavatus"),
  clade_type = list(1)
)

multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Tachybaptus_pelzelnii"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Tachybaptus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Tachybaptus_pelzelnii"),
  clade_type = list(1)
)

Terpsiphone_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Terpsiphone_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Terpsiphone",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Terpsiphone as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Terpsiphone_mutata"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Terpsiphone_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Terpsiphone_mutata"),
  clade_type = list(1)
)

Threskiornis_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Threskiornis_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Threskiornis",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Threskiornis as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Threskiornis_bernieri"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Threskiornis_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Threskiornis_bernieri"),
  clade_type = list(1)
)

Turnix_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Turnix_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Turnix",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Turnix as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Turnix_nigricollis"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Turnix_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Turnix_nigricollis"),
  clade_type = list(1)
)

# Tyto
Tyto_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Tyto_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Tyto",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Tyto as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Tyto_soumagnei"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Tyto_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Tyto_soumagnei"),
  clade_type = list(1)
)


Upupa_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Upupa_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Upupa",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Upupa as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Upupa_marginata"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Upupa_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Upupa_marginata"),
  clade_type = list(1)
)

Vanellus_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Vanellus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Vanellus",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Vanellus as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Vanellus_madagascariensis"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Vanellus_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Vanellus_madagascariensis"),
  clade_type = list(1)
)

DAISIEprep::extract_stem_age(
  genus_name = "Zoonavena",
  phylod = dna_multi_phylods[[1]],
  stem = "genus"
)

# add the Zoonavena as an island age max age as there is no stem age in the tree
multi_island_tbl_dna <- lapply(
  multi_island_tbl_dna,
  DAISIEprep::add_island_colonist,
  clade_name = "Zoonavena_grandidieri",
  status = "endemic",
  missing_species = 0,
  col_time = NA_real_,
  col_max_age = TRUE,
  branching_times = NA_real_,
  min_age = NA_real_,
  species = "Zoonavena_grandidieri",
  clade_type = 1
)

# change missing species of Nectarinia from 1 to 0 as the automatically
# assigned missing species (Cinnyris) is a separate colonist
multi_island_tbl_dna <- lapply(multi_island_tbl_dna, \(x) {
  index <- grep(pattern = "Nectarinia", x@island_tbl$species)
  x@island_tbl$missing_species[index] <- 0
  x
})

# add Cinnyris species as separate colonisation after removing it as missing
# species, we search for the stem age in the genus Nectarinia
Cinnyris_stem_age <- list()
for (i in seq_along(dna_multi_phylods)) {
  Cinnyris_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Nectarinia",
    phylod = dna_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Cinnyris as an stem age max age given the stem age in the tree
multi_island_tbl_dna <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_dna,
  clade_name = list("Cinnyris_notatus"),
  status = list("endemic"),
  missing_species = list(0),
  col_time = Cinnyris_stem_age,
  col_max_age = list(TRUE),
  branching_times = list(NA_real_),
  min_age = list(NA_real_),
  species = list("Cinnyris_notatus"),
  clade_type = list(1)
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
    "bird_it_dna_ds_asr.rds"
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
    "bird_ddt_dna_ds_asr.rds"
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
    "bird_ddl_dna_ds_asr.rds"
  )
)
