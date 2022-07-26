# simulate with amphibian MLE estimates
amphibian <- DAISIE::DAISIE_sim_cr(
  time = 88,
  M = 1000,
  pars = c(0.0684, 0.00000104,  477, 0.0000786, 0.0568),
  replicates = 10,
  divdepmodel = "CS",
  nonoceanic_pars = c(0.000000120, 0),
  sample_freq = 176,
  verbose = TRUE
)

plot_sim <- DAISIE:::DAISIE_convert_to_classic_plot(
  simulation_outputs = amphibian
)
plot_sim <- plot_sim$all_species
plot_tbl <- data.frame(
  taxonomic_group = rep("amphibian", length(plot_sim$stt_average[, "Time"])),
  time = plot_sim$stt_average[, "Time"],
  num_spec = plot_sim$stt_average[, "Total"] + 1,
  upper_quantile = plot_sim$stt_q0.975[, "Total"] + 1,
  lower_quantile = plot_sim$stt_q0.025[, "Total"] + 1
)

# simulate with squamate MLE estimates
squamate <- DAISIE::DAISIE_sim_cr(
  time = 88,
  M = 1000,
  pars = c(0.061, 4.44e-7, 498, 4.01e-4, 0.86),
  replicates = 10,
  divdepmodel = "CS",
  nonoceanic_pars = c(4.28e-8, 0),
  sample_freq = 176,
  verbose = TRUE
)

plot_sim <- DAISIE:::DAISIE_convert_to_classic_plot(
  simulation_outputs = amphibian
)
plot_sim <- plot_sim$all_species
plot_tbl <- rbind(
  plot_tbl,
  data.frame(
    taxonomic_group = rep("squamate", length(plot_sim$stt_average[, "Time"])),
    time = plot_sim$stt_average[, "Time"],
    num_spec = plot_sim$stt_average[, "Total"] + 1,
    upper_quantile = plot_sim$stt_q0.975[, "Total"] + 1,
    lower_quantile = plot_sim$stt_q0.025[, "Total"] + 1
  )
)

  # simulate with bird MLE estimates
  # simulate with nonvolant mammal MLE estimates
# simulate with volant mammal MLE estimates

ggplot2::ggplot(data = plot_tbl) +
  ggplot2::geom_line(
    mapping = ggplot2::aes(
      x = time,
      y = num_spec,
    )) +
  ggplot2::geom_ribbon(
    mapping = ggplot2::aes(
      ymin = lower_quantile,
      ymax = upper_quantile,
      x = time,
      fill = taxonomic_group
    ),
    alpha = 0.1
  ) +
  ggplot2::facet_wrap(facets = "taxonomic_group") +
  ggplot2::scale_y_continuous(
    name = "Number of Island Species",
    trans = "log",
    breaks = scales::breaks_log()
  ) +
  ggplot2::scale_x_continuous(
    name = "Time (Million years ago)",
    trans = "reverse"
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(
    strip.background = ggplot2::element_blank(),
    strip.text = ggplot2::element_blank()
  )
