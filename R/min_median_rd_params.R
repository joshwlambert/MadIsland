#' Takes the collated output from the DAISIE model and calculates which
#' parameter estimates that are closest to the median (i.e. smallest relative
#' deviation from the median for all parameter)
#'
#' @param data Collated daisie output
#'
#' @return tibble
#' @export
min_median_rd_params <- function(data) {

  # get median across all data sets
  median_rates <- summarise_daisie_rates(data = data)

  # replace Inf (mostly K) with 1e4 for sum of squares calculation
  data$value[is.infinite(data$value)] <- 1e10
  median_rates$median[is.infinite(median_rates$median)] <- 1e10

  # calculate sum of squares distance to median for each parameter
  params <- median_rates$params
  res <- list()
  for (i in seq_along(params)) {
    med_rate <- median_rates$median[median_rates$params == params[i]]
    # prevent NaN produced from division by zero with ifelse
    res[[i]] <- abs(data$value[data$params == params[i]] - med_rate) /
      ifelse(test = med_rate == 0, yes = 1, no = med_rate)
  }
  names(res) <- params

  # sum relative deviation diffs
  median_rd <- Reduce(f = `+`, x = res)

  # return dataset that is closest to the median by abs relative deviation
  param_set <- data[data$phylo == which.min(median_rd), ]
  # replace any 1e10 with Inf
  param_set[param_set$params == "K" , "value"] <- ifelse(
    test = param_set[param_set$params == "K" , "value"] == 1e10,
    yes = Inf,
    param_set[param_set$params == "K" , "value"]
  )
  return(param_set)
}
