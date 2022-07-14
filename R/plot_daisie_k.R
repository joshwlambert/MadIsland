plot_daisie_k <- function(oceanic_results_file,
                          nonoceanic_results_file) {

  # get the files names
  oceanic_tbl <- readRDS(
    file = system.file(
      "extdata",
      "collated_daisie_output",
      oceanic_results_file,
      package = "MadIsland",
      mustWork = TRUE
    )
  )

  nonoceanic_tbl <- readRDS(
    file = system.file(
      "extdata",
      "collated_daisie_output",
      nonoceanic_results_file,
      package = "MadIsland",
      mustWork = TRUE
    )
  )

  # keep carrying capacity
  oceanic_k_tbl <- dplyr::filter(
    oceanic_tbl,
    params %in% c("K")
  )

  nonoceanic_k_tbl <- dplyr::filter(
    nonoceanic_tbl,
    params %in% c("K")
  )

  # join the two tables
  k_tbl <- dplyr::right_join(
    oceanic_k_tbl,
    nonoceanic_k_tbl,
    by = c("phylo", "params"),
    suffix = c("_oceanic", "_nonoceanic")
  )

  k_tbl <- tidyr::pivot_longer(
    data = k_tbl,
    cols = c("value_oceanic", "value_nonoceanic"),
    names_to = "model",
    values_to = "k"
  )

  k_tbl$model <- factor(k_tbl$model)

  k_dist <- ggplot2::ggplot(data = k_tbl) +
    ggplot2::geom_density(
      mapping = ggplot2::aes(
        x = k,
        fill = model
      ),
      alpha = 0.2
    ) +
    ggplot2::scale_x_continuous(name = "Carrying Capacity (K')") +
    ggplot2::theme_classic() +
    ggplot2::theme(
      axis.title.y = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank()
    )

  # return k_dist plot
  k_dist

}
