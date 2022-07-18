# summarise squamate daisie fit dna data

squamate_oceanic_fit <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_dna_oceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

squamate_nonoceanic_fit <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_fit(
  oceanic_data = squamate_oceanic_fit,
  nonoceanic_data = squamate_nonoceanic_fit
)

bic_diff <- calc_bic_diff(
  oceanic_data = squamate_oceanic_fit,
  nonoceanic_data = squamate_nonoceanic_fit
)

bic_diff
mean(bic_diff)
sd(bic_diff)
length(which(bic_diff > 0))
length(which(bic_diff < 0))
