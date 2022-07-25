# get the amphibian collated DAISIE output
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

k_plot <- ggplot2::ggplot(data = k_tbl) +
  ggplot2::geom_density(
    mapping = ggplot2::aes(
      x = k,
      fill = taxonomic_group
    ),
    alpha = 0.5
  ) +
  ggplot2::scale_x_continuous(name = "Carrying Capacity (K')") +
  ggplot2::scale_y_continuous(name = "Density") +
  ggplot2::scale_fill_manual(
    labels = c("Amphibian", "Squamate"),
    values = c("#1B9E77", "#7570B3"),
    guide = ggplot2::guide_legend("Taxonomic Group")
  ) +
  ggplot2::guides("Taxonomic Group") +
  ggplot2::theme_classic()

ggplot2::ggsave(
  plot = k_plot,
  filename = file.path(
    "inst",
    "plots",
    "k_dna.png"
  ),
  device = "png",
  width = 150,
  height = 100,
  units = "mm",
  dpi = 600
)
