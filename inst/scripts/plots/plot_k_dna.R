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

# squamates dna carrying capacity
squamate_k_dna <- plot_daisie_k(
  oceanic_results_file = file.path(
    "squamate_daisie_output",
    "squamate_dna_oceanic.rds"
  ),
  nonoceanic_results_file = file.path(
    "squamate_daisie_output",
    "squamate_dna_nonoceanic.rds"
  )
)

densities <- cowplot::plot_grid(
  amphibian_k_dna + ggplot2::theme(legend.position="none"),
  squamate_k_dna + ggplot2::theme(legend.position = "none")
)

# extract the legend from one of the plots
legend <- cowplot::get_legend(
  # create some space to the left of the legend
  amphibian_k_dna + ggplot2::theme(legend.box.margin = ggplot2::margin(0, 0, 0, 12))
)

# add the legend to the row we made earlier. Give it one-third of
# the width of one plot (via rel_widths).
k_plot <- cowplot::plot_grid(densities, legend, rel_widths = c(3, .4))

ggplot2::ggsave(
  plot = k_plot,
  filename = file.path(
    "inst",
    "plots",
    "k_dna.png"
  ),
  device = "png",
  width = 200,
  height = 100,
  units = "mm",
  dpi = 600
)
