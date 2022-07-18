#' Takes the collated output from the DAISIE model and calculates the mean and
#' standard deviation of the log likelihood and Bayesian information criterion
#'
#' @param data Collated daisie output
#'
#' @return tibble
#' @export
summarise_daisie_fit <- function(oceanic_data,
                                 nonoceanic_data) {


  param_tbl <- dplyr::right_join(
    oceanic_data,
    nonoceanic_data,
    by = c("phylo", "params")
  )

  fit_tbl <- dplyr::filter(
    param_tbl,
    params %in% c("loglik", "bic")
  )

  fit_tbl <- dplyr::group_by(fit_tbl, params)
  summary_stats <- dplyr::summarise(
    fit_tbl,
    oceanic_mean = mean(value.x, na.rm = TRUE),
    oceanic_sd = sd(value.x, na.rm = TRUE),
    nonoceanic_mean = mean(value.y, na.rm = TRUE),
    nonoceanic_sd = sd(value.y, na.rm = TRUE)
  )

  # return summary_stats
  summary_stats
}
