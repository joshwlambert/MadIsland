#summarise amphibian daisie rates complete data

amphibian_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = amphibian_nonoceanic_rates)
