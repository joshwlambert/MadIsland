plot_bic_diff <- function(data) {

  ggplot2::ggplot(data = data) +
    ggplot2::geom_violin(
      mapping = ggplot2::aes(
        x = id,
        y = bic_diff
      ),
    ) +
    ggplot2::scale_y_continuous(name = "BIC difference") +
    ggplot2::theme_classic()
}
