# get the amphibian collated DAISIE output for DNA data
amphibian <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

squamate <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

# keep carrying capacity
amphibian_k <- dplyr::filter(
  amphibian,
  params %in% c("K")
)

squamate_k <- dplyr::filter(
  squamate,
  params %in% c("K")
)

# join the two tables
k_tbl <- dplyr::right_join(
  amphibian_k,
  squamate_k,
  by = c("phylo", "params"),
  suffix = c("_amphibian", "_squamate")
)

k_tbl <- tidyr::pivot_longer(
  data = k_tbl,
  cols = c("value_amphibian", "value_squamate"),
  names_to = "taxonomic_group",
  values_to = "k"
)

k_tbl$taxonomic_group <- factor(k_tbl$taxonomic_group)

# set any values greater than 10,000 to infinite for plotting purposes as these
# values can be considered diversity-independent in reality
k_tbl$k[which(k_tbl$k > 10000)] <- Inf

k_plot_dna <- ggplot2::ggplot(data = k_tbl) +
  ggplot2::geom_density(
    mapping = ggplot2::aes(
      x = k,
      fill = taxonomic_group
    ),
    alpha = 0.5
  ) +
  ggplot2::scale_x_continuous(
    name = "Carrying Capacity (K')",
    limits = c(0, max(k_tbl$k[which(is.finite(k_tbl$k))]))
  ) +
  ggplot2::scale_y_continuous(name = "Density") +
  ggplot2::scale_fill_manual(
    labels = c("Amphibian", "Squamate"),
    values = c("#7fbd2d", "#01783f"),
    guide = ggplot2::guide_legend("Taxonomic Group")
  ) +
  ggplot2::guides("Taxonomic Group") +
  ggplot2::theme_classic() +
  ggplot2::theme(
    legend.position = "none",
    plot.title = ggplot2::element_text(hjust = 0.5)
  ) +
  ggplot2::ggtitle(label = "DNA-only")


############################################################


# get the amphibian collated DAISIE output for complete data
amphibian <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

squamate <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_complete_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)


# keep carrying capacity
amphibian_k <- dplyr::filter(
  amphibian,
  params %in% c("K")
)

squamate_k <- dplyr::filter(
  squamate,
  params %in% c("K")
)

# join the two tables
k_tbl <- dplyr::right_join(
  amphibian_k,
  squamate_k,
  by = c("phylo", "params"),
  suffix = c("_amphibian", "_squamate")
)

k_tbl <- tidyr::pivot_longer(
  data = k_tbl,
  cols = c("value_amphibian", "value_squamate"),
  names_to = "taxonomic_group",
  values_to = "k"
)

k_tbl$taxonomic_group <- factor(k_tbl$taxonomic_group)

# set any values greater than 10,000 to infinite for plotting purposes as these
# values can be considered diversity-independent in reality
k_tbl$k[which(k_tbl$k > 10000)] <- Inf

k_plot_complete <- ggplot2::ggplot(data = k_tbl) +
  ggplot2::geom_density(
    mapping = ggplot2::aes(
      x = k,
      fill = taxonomic_group
    ),
    alpha = 0.5
  ) +
  ggplot2::scale_x_continuous(
    name = "Carrying Capacity (K')",
    limits = c(0, max(k_tbl$k[which(is.finite(k_tbl$k))]))
  ) +
  ggplot2::scale_y_continuous(name = NULL) +
  ggplot2::scale_fill_manual(
    labels = c("Amphibian", "Squamate"),
    values = c("#7fbd2d", "#01783f"),
    guide = ggplot2::guide_legend("Taxonomic Group")
  ) +
  ggplot2::guides("Taxonomic Group") +
  ggplot2::theme_classic() +
  ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5)) +
  ggplot2::ggtitle(label = "Complete")

k_plot <- cowplot::plot_grid(
  k_plot_dna,
  k_plot_complete + ggplot2::theme(legend.position = "none"),
  align = "h",
  labels = "AUTO",
  nrow = 1
)

# extract the legend from one of the plots
legend <- cowplot::get_legend(
  k_plot_complete + ggplot2::theme(legend.box.margin = ggplot2::margin(0, 0, 0, 12))
)

# add the legend to the row we made earlier. Give it one-third of
# the width of one plot (via rel_widths).
k_plot <- cowplot::plot_grid(k_plot, legend, rel_widths = c(3, .4))

ggplot2::ggsave(
  plot = k_plot,
  filename = file.path(
    "inst",
    "plots",
    "k_plot.png"
  ),
  device = "png",
  width = 350,
  height = 150,
  units = "mm",
  dpi = 300
)

