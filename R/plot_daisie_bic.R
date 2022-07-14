plot_daisie_bic <- function(results_file_1,
                            results_file_2,
                            bic_diff = TRUE) {

  # get the files names
  params_tbl_1 <- readRDS(
    file = system.file(
      "extdata",
      "collated_daisie_output",
      results_file_1,
      package = "MadIsland",
      mustWork = TRUE
    )
  )

  params_tbl_2 <- readRDS(
    file = system.file(
      "extdata",
      "collated_daisie_output",
      results_file_2,
      package = "MadIsland",
      mustWork = TRUE
    )
  )

  # keep bic
  bic_tbl_1 <- dplyr::filter(
    params_tbl_1,
    params %in% c("bic")
  )

  bic_tbl_2 <- dplyr::filter(
    params_tbl_2,
    params %in% c("bic")
  )

  # join the two tables
  bic_tbl <- dplyr::right_join(
    bic_tbl_1,
    bic_tbl_2,
    by = c("phylo", "params")
  )

  bic_tbl <- dplyr::mutate(bic_tbl, bic_diff = value.x - value.y)

  if (bic_diff) {
    ggplot2::ggplot(data = bic_tbl) +
      ggplot2::geom_violin(
        mapping = ggplot2::aes(
          x = params,
          y = bic_diff
        ),
      ) +
      ggplot2::scale_y_continuous(name = "BIC difference") +
      ggplot2::theme_classic() +
      ggplot2::theme(axis.title.x = ggplot2::element_blank())
  } else {
    ggplot2::ggplot() +
      ggplot2::geom_histogram(
        data = bic_tbl_1,
        mapping = ggplot2::aes(value),
        colour = "red",
        fill = "red",
        alpha = 0.5,
        binwidth = 5
      ) +
      ggplot2::geom_histogram(
        data = bic_tbl_2,
        mapping = ggplot2::aes(value),
        colour = "blue",
        fill = "blue",
        alpha = 0.5,
        binwidth = 5
      ) +
      ggplot2::theme_classic()
  }
}
