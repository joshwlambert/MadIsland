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

densities <- cowplot::plot_grid(
  amphibian_k_complete + ggplot2::theme(legend.position="none"),
  squamate_k_complete + ggplot2::theme(legend.position = "none")
)

# extract the legend from one of the plots
legend <- cowplot::get_legend(
  # create some space to the left of the legend
  amphibian_k_complete + ggplot2::theme(legend.box.margin = ggplot2::margin(0, 0, 0, 12))
)

# add the legend to the row we made earlier. Give it one-third of
# the width of one plot (via rel_widths).
k_plot <- cowplot::plot_grid(densities, legend, rel_widths = c(3, .4))

ggplot2::ggsave(
  plot = k_plot,
  filename = file.path(
    "inst",
    "plots",
    "k_complete.png"
  ),
  device = "png",
  width = 150,
  height = 100,
  units = "mm",
  dpi = 600
)
