plot_daisie_rates <- function(results_file) {

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

  rates_tbl <- dplyr::filter(
    params_tbl,
    params %in% c("lambda_c", "mu", "gamma", "lambda_a")
  )

  rates_tbl <- dplyr::mutate(rates_tbl, params = factor(params))

  ggplot2::ggplot(data = rates_tbl) +
    ggplot2::geom_density(mapping = ggplot2::aes(value)) +
    ggplot2::facet_wrap(ggplot2::vars(params), scales = "free") +
    ggplot2::theme_classic()
}
