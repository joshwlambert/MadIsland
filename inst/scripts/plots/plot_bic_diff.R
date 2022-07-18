# get collated data for each taxonomic group and merged them to be plotted

amphibian_params_tbl_oceanic <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_complete_oceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

amphibian_params_tbl_nonoceanic <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

nonvolant_mammal_params_tbl_oceanic <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "nonvolant_mammal_daisie_output",
    "nonvolant_mammal_complete_oceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

nonvolant_mammal_params_tbl_nonoceanic <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "nonvolant_mammal_daisie_output",
    "nonvolant_mammal_complete_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

volant_mammal_params_tbl_oceanic <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "volant_mammal_daisie_output",
    "volant_mammal_complete_oceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

volant_mammal_params_tbl_nonoceanic <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "volant_mammal_daisie_output",
    "volant_mammal_complete_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

squamate_params_tbl_oceanic <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_complete_oceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

squamate_params_tbl_nonoceanic <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_complete_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

# join the two tables
amphibian_param_tbl <- dplyr::right_join(
  amphibian_params_tbl_oceanic,
  amphibian_params_tbl_nonoceanic,
  by = c("phylo", "params")
)

nonvolant_mammal_param_tbl <- dplyr::right_join(
  nonvolant_mammal_params_tbl_oceanic,
  nonvolant_mammal_params_tbl_nonoceanic,
  by = c("phylo", "params")
)

volant_mammal_param_tbl <- dplyr::right_join(
  volant_mammal_params_tbl_oceanic,
  volant_mammal_params_tbl_nonoceanic,
  by = c("phylo", "params")
)

squamate_param_tbl <- dplyr::right_join(
  squamate_params_tbl_oceanic,
  squamate_params_tbl_nonoceanic,
  by = c("phylo", "params")
)

# keep bic
amphibian_bic_tbl <- dplyr::filter(
  amphibian_param_tbl,
  params %in% c("bic")
)

nonvolant_mammal_bic_tbl <- dplyr::filter(
  nonvolant_mammal_param_tbl,
  params %in% c("bic")
)

volant_mammal_bic_tbl <- dplyr::filter(
  volant_mammal_param_tbl,
  params %in% c("bic")
)

squamate_bic_tbl <- dplyr::filter(
  squamate_param_tbl,
  params %in% c("bic")
)

# calculate bic difference
amphibian_bic_tbl <- dplyr::mutate(
  amphibian_bic_tbl,
  bic_diff = value.x - value.y
)

nonvolant_mammal_bic_tbl <- dplyr::mutate(
  nonvolant_mammal_bic_tbl,
  bic_diff = value.x - value.y
)

volant_mammal_bic_tbl <- dplyr::mutate(
  volant_mammal_bic_tbl,
  bic_diff = value.x - value.y
)

squamate_bic_tbl <- dplyr::mutate(
  squamate_bic_tbl,
  bic_diff = value.x - value.y
)

# join the two tables
bic_tbl <- dplyr::bind_rows(
  amphibian_bic_tbl,
  nonvolant_mammal_bic_tbl,
  volant_mammal_bic_tbl,
  squamate_bic_tbl,
  .id = c("id")
)

plot_bic_diff(data = bic_tbl)
