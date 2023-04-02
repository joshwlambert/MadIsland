plot_daisie_rates <- function(results_file, plot_col) {

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

  rates_plot <- ggplot2::ggplot(data = rates_tbl) +
    ggplot2::geom_density(
      mapping = ggplot2::aes(value),
      fill = plot_col,
      alpha = 0.75) +
    ggplot2::facet_wrap(
      ggplot2::vars(params),
      scales = "free",
      strip.position = "bottom",
      labeller = ggplot2::as_labeller(c(
        lambda_a = "Anagenesis",
        lambda_c = "Cladogenesis",
        mu = "Extinction",
        gamma =  "Colonisation"))
    ) +
    ggplot2::scale_x_continuous(name = "") +
    ggplot2::theme_classic() +
    ggplot2::theme(
      axis.title.y = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      axis.ticks.y = ggplot2::element_blank(),
      strip.background = ggplot2::element_blank(),
      strip.placement = "outside",
      text = ggplot2::element_text(size = 7)
    )

  # return rates_plot
  rates_plot
}
