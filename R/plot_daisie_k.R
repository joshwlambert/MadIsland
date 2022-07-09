plot_daisie_k <- function(results_file) {

  # get the files names
  params_tbl <- readRDS(
    file = system.file(
      "extdata",
      "collated_daisie_output",
      results_file,
      package = "MadIsland",
      mustWork = TRUE
    )
  )

  k_tbl <- dplyr::filter(
    params_tbl,
    params %in% c("K")
  )

  ggplot2::ggplot(data = k_tbl) +
    ggplot2::geom_density(
      mapping = ggplot2::aes(value),
      fill = "red",
      alpha = 0.2
    ) +
    ggplot2::scale_x_continuous(name = "Carrying Capacity (K')") +
    ggplot2::theme_classic() +
    ggplot2::theme(
      axis.title.y = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank()
    )

}
