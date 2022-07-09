# script to plot the parameter estimates of the amphibian data

# amphibians complete oceanic rates
plot_daisie_rates(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_oceanic.rds"
  )
)

# amphibians complete oceanic carrying capacity
plot_daisie_k(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_oceanic.rds"
  )
)

# amphibians complete nonoceanic rates
plot_daisie_rates(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds"
  )
)

# amphibians complete nonoceanic carrying capacity
plot_daisie_k(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds"
  )
)

# amphibians DNA oceanic rates
plot_daisie_rates(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_dna_oceanic.rds"
  )
)

# amphibians DNA oceanic carrying capacity
plot_daisie_k(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_dna_oceanic.rds"
  )
)

# amphibians DNA nonoceanic rates
plot_daisie_rates(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_dna_nonoceanic.rds"
  )
)

# amphibians DNA nonoceanic carrying capacity
plot_daisie_k(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_dna_nonoceanic.rds"
  )
)


