# summarise amphibian daisie fit dna data

amphibian_oceanic_fit <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_dna_oceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

amphibian_nonoceanic_fit <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_fit(
  oceanic_data = amphibian_oceanic_fit,
  nonoceanic_data = amphibian_nonoceanic_fit
)

bic_diff <- calc_bic_diff(
  oceanic_data = amphibian_oceanic_fit,
  nonoceanic_data = amphibian_nonoceanic_fit
)

bic_diff
mean(bic_diff)
sd(bic_diff)
