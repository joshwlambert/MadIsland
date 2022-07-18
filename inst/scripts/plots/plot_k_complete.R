# amphibians complete carrying capacity
amphibian_k_complete <- plot_daisie_k(
  oceanic_results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_oceanic.rds"
  ),
  nonoceanic_results_file = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds"
  )
)

# squamates complete carrying capacity
squamate_k_complete <- plot_daisie_k(
  oceanic_results_file = file.path(
    "squamate_daisie_output",
    "squamate_complete_oceanic.rds"
  ),
  nonoceanic_results_file = file.path(
    "squamate_daisie_output",
    "squamate_complete_nonoceanic.rds"
  )
)

cowplot::plot_grid(amphibian_k_complete, squamate_k_complete)

# ggsave
