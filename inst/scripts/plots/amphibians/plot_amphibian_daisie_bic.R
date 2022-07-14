plot_daisie_bic(
  results_file_1 = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_oceanic.rds"
  ),
  results_file_2 = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds"
  ),
  bic_diff = TRUE
)

plot_daisie_bic(
  results_file_1 = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_oceanic.rds"
  ),
  results_file_2 = file.path(
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds"
  ),
  bic_diff = FALSE
)
