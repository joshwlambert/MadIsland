# script to plot the parameter estimates of the amphibian data

# amphibians complete oceanic rates
oceanic_rates_complete <- plot_daisie_rates(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_oceanic.rds"
  )
)

# amphibians complete nonoceanic rates
nonoceanic_rates_complete <- plot_daisie_rates(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds"
  )
)

# amphibians DNA oceanic rates
oceanic_rates_dna <- plot_daisie_rates(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_dna_oceanic.rds"
  )
)

# amphibians DNA nonoceanic rates
nonoceanic_rates_dna <- plot_daisie_rates(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_dna_nonoceanic.rds"
  )
)

rates_complete <- cowplot::plot_grid(oceanic_rates_complete, nonoceanic_rates_complete)
rates_dna <- cowplot::plot_grid(oceanic_rates_dna, nonoceanic_rates_dna)
