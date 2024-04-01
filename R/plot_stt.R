plot_stt <- function(daisie_data_list,
                     log_num_species = TRUE,
                     median_res = 1) {

  # Fix build warnings
  num_lineages <- NULL; rm(num_lineages) # nolint, fixes warning: no visible binding for global variable

  if (log_num_species) {
    trans <- "log"
    breaks <- scales::breaks_log()
  } else {
    trans <- "identity"
    breaks <- ggplot2::waiver()
  }

  island_age <- daisie_data_list[[1]][[1]]$island_age

  stt_list <- list()
  median_stt_list <- list()
  for (i in seq_along(daisie_data_list)) {

    event_times <- lapply(daisie_data_list[[i]], "[[", "branching_times")
    event_times <- sort(unlist(event_times), decreasing = TRUE)
    event_times <- event_times[-which(event_times == island_age)]

    stt_list[[i]] <- tibble::tibble(
      num_lineages = seq_along(event_times),
      event_times = event_times
    )

    # calculate median stt line
    time_step <- island_age
    num_species <- c()
    time <- c()
    while(time_step > 0) {
      num_species <- c(
        num_species,
        length(which(
          stt_list[[i]]$event_times < time_step &
            stt_list[[i]]$event_times >= time_step - median_res
        ))
      )
      time <- c(time, time_step)
      time_step <- time_step - median_res
    }

    median_stt_list[[i]] <-  cumsum(num_species)
  }

  stt_plot <- ggplot2::ggplot(data = stt_list[[1]]) +
    ggplot2::geom_line(
      mapping = ggplot2::aes(
        x = event_times,
        y = num_lineages
      ),
      colour = "azure3",
      alpha = 0.5
    ) +
    ggplot2::scale_y_continuous(
      name = "Number of Extant Island Species",
      trans = trans,
      breaks = breaks
    ) +
    ggplot2::scale_x_continuous(
      name = "Time (Million years ago)",
      trans = "reverse",
      limits = c(island_age, 0)
    ) +
    ggplot2::theme_classic()

  for (i in 2:length(stt_list)) {
    stt_plot <- stt_plot +
      ggplot2::geom_line(
        data = stt_list[[i]],
        mapping = ggplot2::aes(
          x = event_times,
          y = num_lineages
        ),
        colour = "azure3",
        alpha = 0.5
      )
  }

  # calculate median stt from median_stt_list
  check_length <- length(unique(
    vapply(
      median_stt_list,
      length,
      FUN.VALUE = numeric(1))
  )) == 1
  if (isFALSE(check_length)) {
    stop("length of vectors must be the same to calculate median")
  }

  # calculate the median number of species for each replicate
  median_stt <- c()
  for (i in seq_along(median_stt_list[[1]])) {
    median_stt[i] <- stats::median(
      vapply(median_stt_list, "[[", i, FUN.VALUE = numeric(1))
    )
  }

  # create tibble with median stt
  median_stt <- tibble::tibble(
    num_lineages = median_stt,
    event_times = time
  )

  # remove any rows where the number of species is zero due to log transform
  median_stt <- dplyr::filter(median_stt, num_lineages >= 1)

  # add the median stt line to plot
  stt_plot <- stt_plot +
    ggplot2::geom_line(
      data = median_stt,
      mapping = ggplot2::aes(
        x = event_times,
        y = num_lineages
      ),
      colour = "black",
      alpha = 1.0
    )

  # return stt plot
  stt_plot
}
