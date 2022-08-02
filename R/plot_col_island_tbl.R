#' Plots the distribution of colonisation times (points) across the history
#' of an island for each taxonomic group given in the list of multi_island_tbl
#' objects
#'
#' @param multi_island_tbl_list Named list of daisie_data_list objects
#' @param col_time A character string, either "stem" or "crown"
#'
#' @return ggplot2 object
#' @export
#'
#' @examples
#' amphibians <- readRDS(file = system.file(
#'   "extdata",
#'   "extracted_data",
#'   "amphibian_data",
#'   "amphibian_island_tbl_complete_ds_asr.rds",
#'   package = "MadIsland",
#'   mustWork = TRUE
#' ))
#'
#' mammals <- readRDS(file = system.file(
#'   "extdata",
#'   "extracted_data",
#'   "mammal_data",
#'   "mammal_island_tbl_complete_ds_asr.rds",
#'   package = "MadIsland",
#'   mustWork = TRUE
#' ))
#'
#' squamates <- readRDS(file = system.file(
#'   "extdata",
#'   "extracted_data",
#'   "squamate_data",
#'   "squamate_island_tbl_complete_ds_asr.rds",
#'   package = "MadIsland",
#'   mustWork = TRUE
#' ))
#'
#' multi_island_tbl_list <- list(
#'   Amphibians = amphibians,
#'   Mammals = mammals,
#'   Squamates = squamates
#' )
#' plot_col_island_tbl(multi_island_tbl_list = multi_island_tbl_list)
plot_col_island_tbl <- function(multi_island_tbl_list,
                                col_time = "stem") {

  if (is.null(names(multi_island_tbl_list))) {
    stop("Data must be a named list to use the names for plotting")
  }

  # create empty data frame
  col_tbl <- data.frame()


  # loop over each multi_island_tbl
  for (i in seq_along(multi_island_tbl_list)) {

    for (j in seq_along(multi_island_tbl_list[[i]])) {

      # extract the colonisation times from each island data set
      if (col_time == "stem") {
        col_times <- multi_island_tbl_list[[i]][[j]]@island_tbl$col_time
      } else if (col_time == "crown") {
        col_times <- unlist(lapply(
          multi_island_tbl_list[[i]][[j]]@island_tbl$branching_times,
          "[[",
          1
        ))
      } else {
        stop("col_time argument must be either 'stem' or 'crown'")
      }


      # create temp data frame
      temp_tbl <- data.frame(
        clade = rep(names(multi_island_tbl_list)[i], length(col_times)),
        posterior_index = rep(j, length(col_times)),
        col_times = col_times
      )
      col_tbl <- rbind(col_tbl, temp_tbl)

    }
  }

  # create a tibble with name of group and colonisation times
  col_tbl <- tibble::as_tibble(col_tbl)

  if (col_time == "stem") {
    xlab <- "Colonisation time (Million years ago)"
  } else {
    xlab <- "Crown age (Million years ago)"
  }

  # plot colonisation times
  col_times_plot <- ggplot2::ggplot(data = col_tbl) +
    ggplot2::geom_point(
      mapping = ggplot2::aes(
        x = col_times,
        y = posterior_index,
        colour = clade
      ),
      alpha = 0.5
    ) +
    ggplot2::facet_wrap(
      facets = "clade",
      ncol = 1,
      strip.position = "left",
      labeller = ggplot2::labeller(clade = c(
        Amphibians = "Amphibians",
        Nonvolant_Mammals = "NV Mammals",
        Volant_Mammals = "V Mammals",
        Squamates = "Squamates",
        Birds = "Birds"
      ))
    ) +
    ggplot2::scale_y_discrete(
      name = "Taxonomic group"
    ) +
    ggplot2::scale_x_continuous(
      name = xlab,
      trans = "reverse",
      breaks = scales::breaks_extended(n = 8)
    ) +
    ggplot2::scale_color_brewer(palette = "Dark2") +
    ggplot2::theme_classic() +
    ggplot2::theme(
      legend.position = "none",
      axis.line.y = ggplot2::element_blank(),
      strip.background = ggplot2::element_blank(),
      strip.placement = "outside",
      strip.text = ggplot2::element_text(size = 8)
    )

  # return col_times_plot
  col_times_plot
}
