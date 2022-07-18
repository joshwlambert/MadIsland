# summarise volant_mammal daisie fit complete data

volant_mammal_oceanic_fit <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "volant_mammal_daisie_output",
    "volant_mammal_complete_oceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

volant_mammal_nonoceanic_fit <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "volant_mammal_daisie_output",
    "volant_mammal_complete_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_fit(
  oceanic_data = volant_mammal_oceanic_fit,
  nonoceanic_data = volant_mammal_nonoceanic_fit
)

bic_diff <- calc_bic_diff(
  oceanic_data = volant_mammal_oceanic_fit,
  nonoceanic_data = volant_mammal_nonoceanic_fit
)

bic_diff
mean(bic_diff)
sd(bic_diff)
