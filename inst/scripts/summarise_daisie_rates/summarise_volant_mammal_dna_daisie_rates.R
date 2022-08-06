#summarise volant mammal daisie rates dna data

volant_mammal_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "volant_mammal_daisie_output",
    "volant_mammal_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = volant_mammal_nonoceanic_rates)
