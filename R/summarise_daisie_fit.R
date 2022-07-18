#' Takes the collated output from the DAISIE model and calculates the mean and
#' standard deviation of the log likelihood and Bayesian information criterion
#'
#' @param data Collated daisie output
#'
#' @return tibble
#' @export
summarise_daisie_fit <- function(data) {

  params_tbl <- dplyr::filter(
    data,
    params %in% c("loglik", "bic")
  )
  params_tbl <- dplyr::group_by(params_tbl, params)
  summary_stats <- dplyr::summarise(
    params_tbl,
    mean = mean(value, na.rm = TRUE),
    sd = sd(value, na.rm = TRUE)
  )

  # return summary_stats
  summary_stats
}
