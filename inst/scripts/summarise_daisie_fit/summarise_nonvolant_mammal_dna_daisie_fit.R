# summarise nonvolant_mammal daisie fit dna data

nonvolant_mammal_oceanic_fit <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "nonvolant_mammal_daisie_output",
    "nonvolant_mammal_dna_oceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

nonvolant_mammal_nonoceanic_fit <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "nonvolant_mammal_daisie_output",
    "nonvolant_mammal_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_fit(
  oceanic_data = nonvolant_mammal_oceanic_fit,
  nonoceanic_data = nonvolant_mammal_nonoceanic_fit
)

bic_diff <- calc_bic_diff(
  oceanic_data = nonvolant_mammal_oceanic_fit,
  nonoceanic_data = nonvolant_mammal_nonoceanic_fit
)

bic_diff
mean(bic_diff)
sd(bic_diff)
