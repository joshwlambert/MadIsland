#' Plots the distribution of colonisation times (points) across the history
#' of an island for each taxonomic group given in the list of daisie_data_list
#' objects
#'
#' @param listed_daisie_data_list Named list of daisie_data_list objects
#' @param col_time A character string, either "stem" or "crown"
#'
#' @return ggplot2 object
#' @export
#'
#' @examples
#' data("amp_ddl_complete_ds_asr")
#' data("vm_ddl_complete_ds_asr")
#' data("squa_ddl_complete_ds_asr")
#' daisie_data_list <- list(
#'   Amphibians = amp_ddl_complete_ds_asr,
#'   Mammals = vm_ddl_complete_ds_asr,
#'   Squamates = squa_ddl_complete_ds_asr
#' )
#' plot_col_daisie_data_list(listed_daisie_data_list = daisie_data_list)
plot_col_daisie_data_list <- function(listed_daisie_data_list,
                                      col_time = "stem") {

  #TODO implement crown age plotting

  if (is.null(names(daisie_data_list))) {
    stop("Data must be a named list to use the names for plotting")
  }

  col_times_list <- list()
  # loop over each daisie_data_list
  for (i in seq_along(daisie_data_list)) {

    # extract the event times from each island data set
    event_times <- lapply(daisie_data_list[[i]], \(x) {
      lapply(x, "[[", "branching_times")
    })

    # delete meta data (first element) from each data set
    event_times <- lapply(event_times, \(x) {
      x[-1]
    })

    # extact colonisation time for each colonist (first element is island age)
    col_times <- unlist(lapply(event_times, \(x) {
      vapply(x, "[[", 2, FUN.VALUE = numeric(1))
    }))

    # store col_times in list
    col_times_list[[i]] <- col_times
  }

  # name list
  names(col_times_list) <- names(daisie_data_list)

  # create a tibble with name of group and colonisation times
  col_tbl <- tibble::as_tibble(utils::stack(col_times_list))

  colnames(col_tbl) <- c("col_times", "clade")

  # plot colonisation times
  col_times_plot <- ggplot2::ggplot(data = col_tbl) +
    ggplot2::geom_point(
      mapping = ggplot2::aes(
        x = col_times,
        y = clade,
        colour = clade
      ),
      alpha = 0.5,
      position = "jitter"
    ) +
    ggplot2::scale_y_discrete(
      name = "Taxonomic group"
    ) +
    ggplot2::scale_x_continuous(
      name = "Colonisation time (Million years ago)",
      trans = "reverse"
    ) +
    ggplot2::scale_color_brewer(palette = "Dark2") +
    ggplot2::theme_classic() +
    ggplot2::theme(legend.position = "none")

  # return col_times_plot
  col_times_plot
}
