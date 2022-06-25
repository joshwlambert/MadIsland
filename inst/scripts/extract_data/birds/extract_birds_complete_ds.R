library(MadIsland)

island_data <- MadIsland::extract_species(
  checklist_file_name = "bird_checklist.csv",
  phylo_file_name = "Jetz_complete_posterior_100.nex",
  dna_or_complete = "complete",
  daisie_status = TRUE,
  extraction_method = "min"
)

multi_island_tbl_complete <- island_data$multi_island_tbl
no_phylo_missing_species <- island_data$no_phylo_missing_species
complete_multi_phylods <- island_data$phylods

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
    "bird_data",
    "bird_island_tbl_complete_ds.rds"
  )
)

# 2) the DAISIE data table
saveRDS(
  object = daisie_datatable_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "bird_data",
    "bird_daisie_datatable_complete_ds.rds"
  )
)

# 3) the DAISIE data list
saveRDS(
  object = daisie_data_list_complete,
  file = file.path(
    "inst",
    "extdata",
    "extracted_data",
    "bird_data",
    "bird_daisie_data_list_complete_ds.rds"
  )
)
