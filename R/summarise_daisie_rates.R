#' Takes the collated output from the DAISIE model and calculates the mean and
#' standard deviation of each of the five or six model parameters
#'
#' @param data Collated daisie output
#'
#' @return tibble
#' @export
summarise_daisie_rates <- function(data) {

  params_tbl <- dplyr::filter(
    data,
    params %in% c("lambda_c", "mu", "K", "gamma", "lambda_a", "prob_init_pres")
  )
  params_tbl <- dplyr::group_by(params_tbl, params)
  summary_stats <- dplyr::summarise(
    params_tbl,
    median = stats::median(value, na.rm = TRUE),
    sd = stats::sd(value, na.rm = TRUE)
  )

  # return summary_stats
  summary_stats
}
