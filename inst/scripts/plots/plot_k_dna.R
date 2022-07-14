# amphibians dna carrying capacity
amphibian_k_dna <- plot_daisie_k(
  oceanic_results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_dna_oceanic.rds"
  ),
  nonoceanic_results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_dna_nonoceanic.rds"
  )
)

cowplot::plot_grid(amphibian_k_dna)

# ggsave()
