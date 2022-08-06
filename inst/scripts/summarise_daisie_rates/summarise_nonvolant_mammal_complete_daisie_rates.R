#summarise nonvolant mammal daisie rates complete data

nonvolant_mammal_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "nonvolant_mammal_daisie_output",
    "nonvolant_mammal_complete_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = nonvolant_mammal_nonoceanic_rates)
