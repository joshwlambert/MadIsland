library(MadIsland)
# load ape to prevent class conversion issues, not 100% sure why but could be
# class-specific subsetting that is exported in ape
library(ape)

island_data <- MadIsland::extract_species(
  checklist_file_name = "bird_checklist.csv",
  phylo_file_name = "Jetz_complete_posterior_100.rds",
  dna_or_complete = "complete",
  daisie_status = TRUE,
  extraction_method = "asr"
)

multi_island_tbl_complete <- island_data$multi_island_tbl
no_island_tbl_missing_species <- island_data$no_island_tbl_missing_species
complete_multi_phylods <- island_data$phylods

# check which missing species that are not already assigned have stem ages in
# the tree, when no stem is found only one tree needs to be checked as each
# tree in the posterior contains the same species and just differs in branch
# lengths and topology, when the stem age is found, a stem age from each tree is
# required

# add the elephant birds (Aepyornis, Mullerornis and  Vorombe) as an island age
# max age as there is no stem age in the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
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
for (i in seq_along(complete_multi_phylods)) {
  Alopochen_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Alopochen",
    phylod = complete_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Alopochen as an stem age max age given the stem age in the tree
multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
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

Aquila_stem_age <- list()
for (i in seq_along(complete_multi_phylods)) {
  Aquila_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Aquila",
    phylod = complete_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Aquila as an stem age max age given the stem age in the tree
multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
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

DAISIEprep::extract_stem_age(
  genus_name = "Centrornis",
  phylod = complete_multi_phylods[[1]],
  stem = "genus"
)

# add the Centrornis as an island age max age as there is no stem age in the
# tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
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

# Cypsiurus
Cypsiurus_stem_age <- list()
for (i in seq_along(complete_multi_phylods)) {
  Cypsiurus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Cypsiurus",
    phylod = complete_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Cypsiurus as an stem age max age given the stem age in the tree
multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
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
  genus_name = "Hovacrex",
  phylod = complete_multi_phylods[[1]],
  stem = "genus"
)

# add the Hovacrex as an island age max age as there is no stem age in the tree
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
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

# add the Mentocrex as a missing species of the clade with
# Canirallus_kioloides in it as they come from a single colonisation
# on Madagascar
multi_island_tbl_complete <- lapply(
  multi_island_tbl_complete,
  DAISIEprep::add_missing_species,
  num_missing_species = 1,
  species_to_add_to = "Canirallus_kioloides"
)

Phalacrocorax_stem_age <- list()
for (i in seq_along(complete_multi_phylods)) {
  Phalacrocorax_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Phalacrocorax",
    phylod = complete_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Phalacrocorax endemic species as an stem age max age given the stem
# age in the tree
multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
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

Stephanoaetus_stem_age <- list()
for (i in seq_along(complete_multi_phylods)) {
  Stephanoaetus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Stephanoaetus",
    phylod = complete_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Stephanoaetus as an stem age max age given the stem age in the tree
multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
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

Vanellus_stem_age <- list()
for (i in seq_along(complete_multi_phylods)) {
  Vanellus_stem_age[[i]] <- DAISIEprep::extract_stem_age(
    genus_name = "Vanellus",
    phylod = complete_multi_phylods[[i]],
    stem = "genus"
  )
}

# add the Vanellus as an stem age max age given the stem age in the tree
multi_island_tbl_complete <- mapply(
  DAISIEprep::add_island_colonist,
  multi_island_tbl_complete,
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
    "bird_it_complete_ds_asr.rds"
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
    "bird_ddt_complete_ds_asr.rds"
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
    "bird_ddl_complete_ds_asr.rds"
  )
)
