#summarise bird daisie rates DNA data

bird_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "bird_daisie_output",
    "bird_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = bird_nonoceanic_rates)
