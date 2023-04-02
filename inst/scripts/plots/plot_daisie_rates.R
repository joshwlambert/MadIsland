# script to plot the parameter estimates of the amphibian data

# amphibians complete nonoceanic rates
amphibians_complete <- plot_daisie_rates(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds"
  ),
  plot_col = "#7fbd2d"
)

# amphibians DNA nonoceanic rates
amphibians_dna <- plot_daisie_rates(
  results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_dna_nonoceanic.rds"
  ),
  plot_col = "#7fbd2d"
)

# birds complete nonoceanic rates
birds_complete <- plot_daisie_rates(
  results_file = file.path(
    "bird_daisie_output",
    "bird_complete_nonoceanic.rds"
  ),
  plot_col = "#073dfd"
)

# birds DNA nonoceanic rates
bird_dna <- plot_daisie_rates(
  results_file = file.path(
    "bird_daisie_output",
    "bird_dna_nonoceanic.rds"
  ),
  plot_col = "#073dfd"
)

# non-volant mammals complete nonoceanic rates
nonvolant_mammals_complete <- plot_daisie_rates(
  results_file = file.path(
    "nonvolant_mammal_daisie_output",
    "nonvolant_mammal_complete_nonoceanic.rds"
  ),
  plot_col = "#a8856e"
)

# non-volant mammals DNA nonoceanic rates
nonvolant_mammals_dna <- plot_daisie_rates(
  results_file = file.path(
    "nonvolant_mammal_daisie_output",
    "nonvolant_mammal_dna_nonoceanic.rds"
  ),
  plot_col = "#a8856e"
)

# squamates complete nonoceanic rates
squamates_complete <- plot_daisie_rates(
  results_file = file.path(
    "squamate_daisie_output",
    "squamate_complete_nonoceanic.rds"
  ),
  plot_col = "#01783f"
)

# amphibians DNA nonoceanic rates
squamates_dna <- plot_daisie_rates(
  results_file = file.path(
    "squamate_daisie_output",
    "squamate_dna_nonoceanic.rds"
  ),
  plot_col = "#01783f"
)

# volant mammals complete nonoceanic rates
volant_mammals_complete <- plot_daisie_rates(
  results_file = file.path(
    "volant_mammal_daisie_output",
    "volant_mammal_complete_nonoceanic.rds"
  ),
  plot_col = "#3d3d3d"
)

# volant mammals DNA nonoceanic rates
volant_mammals_dna <- plot_daisie_rates(
  results_file = file.path(
    "volant_mammal_daisie_output",
    "volant_mammal_dna_nonoceanic.rds"
  ),
  plot_col = "#3d3d3d"
)

complete_daisie_rates <- cowplot::plot_grid(
  amphibians_complete,
  birds_complete,
  nonvolant_mammals_complete,
  squamates_complete,
  volant_mammals_complete
)

ggplot2::ggsave(
  plot = complete_daisie_rates,
  filename = file.path(
    "inst",
    "plots",
    "daisie_rates_complete.png"
  ),
  device = "png",
  width = 150,
  height = 100,
  units = "mm",
  dpi = 600
)

dna_daisie_rates <- cowplot::plot_grid(
  amphibians_dna,
  birds_complete,
  nonvolant_mammals_dna,
  squamates_dna,
  volant_mammals_dna
)

ggplot2::ggsave(
  plot = dna_daisie_rates,
  filename = file.path(
    "inst",
    "plots",
    "daisie_rates_dna.png"
  ),
  device = "png",
  width = 150,
  height = 100,
  units = "mm",
  dpi = 600
)
