plot_bic_dist <- function(data) {

  ggplot2::ggplot() +
    ggplot2::geom_histogram(
      data = .data$bic_tbl_1,
      mapping = ggplot2::aes(.data$value),
      colour = "red",
      fill = "red",
      alpha = 0.5,
      binwidth = 5
    ) +
    ggplot2::geom_histogram(
      data = .data$bic_tbl_2,
      mapping = ggplot2::aes(.data$value),
      colour = "blue",
      fill = "blue",
      alpha = 0.5,
      binwidth = 5
    ) +
    ggplot2::theme_classic()
}
