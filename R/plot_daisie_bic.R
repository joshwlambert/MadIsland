plot_daisie_bic <- function(results_file_1,
                            results_file_2) {

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

  bic_tbl <- dplyr::filter(
    params_tbl,
    params %in% c("bic")
  )

  ggplot2::ggplot(data = bic_tbl) +
    ggplot2::geom_density(mapping = ggplot2::aes(value)) +
    ggplot2::theme_classic()
}
