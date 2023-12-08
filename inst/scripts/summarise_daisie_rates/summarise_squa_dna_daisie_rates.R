#summarise squamate daisie rates dna data

squamate_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = squamate_nonoceanic_rates)
