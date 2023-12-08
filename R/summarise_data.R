#' Calculates the summary statistics for island community data that has been
#' extracted and formatted as an `Island_tbl` class.
#'
#' @param data An `Island_tbl` or list of `Island_tbl` objects
#'
#' @return List of numerics
#' @export
#'
#' @examples
#' amphibians <- readRDS(file = system.file(
#'   "extdata",
#'   "extracted_data",
#'   "amp_data",
#'   "amp_it_complete_ds_asr.rds",
#'   package = "MadIsland",
#'   mustWork = TRUE
#' ))
#' summarise_data(data = amphibians)
summarise_data <- function(data) {

  # calculate mean and sd maximum (oldest) colonisation time across each posterior
  col_times <- lapply(data, \(x) {x@island_tbl$col_time})
  max_col_time <- unlist(lapply(col_times, max, na.rm = TRUE))
  mean_max_col_time <- mean(max_col_time)
  sd_max_col_time <- stats::sd(max_col_time)

  # calculate mean and sd minimum (youngest) colonisation time across each posterior
  min_col_time <- unlist(lapply(col_times, min, na.rm = TRUE))
  mean_min_col_time <- mean(min_col_time)
  sd_min_col_time <- stats::sd(min_col_time)

  # calculate mean and sd number of colonisation event across each posterior
  num_col <- unlist(lapply(data, \(x) {nrow(x@island_tbl)}))
  mean_num_col <- mean(num_col)
  sd_num_col <- stats::sd(num_col)

  # calculate the mean and sd for the largest island clade across each posterior

  # number of species is 1 when there are no branching times (NA) and branching
  # times plus 1 when there are branching times
  clade_size <- lapply(data, \(x) {
    unlist(lapply(x@island_tbl$branching_times, \(y) {
      if(is.na(y[1])) 1 else length(y) + 1
    }))
  })
  missing_species <- lapply(data, \(x) {
    x@island_tbl$missing_species
  })
  clade_size <- mapply(FUN = `+`, clade_size, missing_species, SIMPLIFY = FALSE)

  max_clade_size <- unlist(lapply(clade_size, max))
  mean_max_clade_size <- mean(max_clade_size)
  sd_max_clade_size <- stats::sd(max_clade_size)

  # calculate the mean and sd for the smallest island clade across each posterior
  min_clade_size <- unlist(lapply(clade_size, min))
  mean_min_clade_size <- mean(min_clade_size)
  sd_min_clade_size <- stats::sd(min_clade_size)

  # calculate the mean and sd for the number of clades that have at least 2
  # species across each posterior
  num_two_species_radiation <- unlist(lapply(clade_size, \(x) {
    length(which(x >= 2))
  }))
  mean_num_two_species_radiation <- mean(num_two_species_radiation)
  sd_num_two_species_radiation <- stats::sd(num_two_species_radiation)

  # calculate the mean and sd for the number of clades that have at least 5
  # species across each posterior
  num_five_species_radiation <- unlist(lapply(clade_size, \(x) {
    length(which(x >= 5))
  }))
  mean_num_five_species_radiation <- mean(num_five_species_radiation)
  sd_num_five_species_radiation <- stats::sd(num_five_species_radiation)

  # calculate the mean and sd for the percentage endemism across each posterior
  status <- lapply(data, \(x) {x@island_tbl$status})
  status_per_species <- mapply(rep, status, clade_size)
  if (inherits(status_per_species, "matrix")) {
    percent_endemic <- apply(
      X = status_per_species,
      MARGIN = 2,
      FUN = \(x) {
        sum(x == "endemic") / (sum(x != "endemic") + sum(x == "endemic")) * 100
      },
      simplify = TRUE
    )
  } else if (inherits(status_per_species, "list")) {
    percent_endemic <- unlist(lapply(status_per_species, \(x) {
      sum(x == "endemic") / (sum(x != "endemic") + sum(x == "endemic")) * 100
    }))
  }

  mean_percent_endemic <- mean(percent_endemic)
  sd_percent_endemic <- stats::sd(percent_endemic)

  # return list of summary statistics
  list(
    mean_max_col_time = mean_max_col_time,
    sd_max_col_time = sd_max_col_time,
    mean_min_col_time = mean_min_col_time,
    sd_min_col_time = sd_min_col_time,
    mean_num_col = mean_num_col,
    sd_num_col = sd_num_col,
    mean_max_clade_size = mean_max_clade_size,
    sd_max_clade_size = sd_max_clade_size,
    mean_min_clade_size = mean_min_clade_size,
    sd_min_clade_size = sd_min_clade_size,
    mean_num_two_species_radiation = mean_num_two_species_radiation,
    sd_num_two_species_radiation = sd_num_two_species_radiation,
    mean_num_five_species_radiation = mean_num_five_species_radiation,
    sd_num_five_species_radiation = sd_num_five_species_radiation,
    mean_percent_endemic = mean_percent_endemic,
    sd_percent_endemic = sd_percent_endemic
  )
}
