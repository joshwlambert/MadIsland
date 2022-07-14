#summarise squamate daisie rates complete data

squamate_oceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_complete_oceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = squamate_oceanic_rates)


squamate_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_complete_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = squamate_nonoceanic_rates)
