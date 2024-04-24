# amphibians

# load collated DAISIE MLE estimates
amphibian_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amp_daisie_output",
    "amp_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

# calculate median rates
amphibian_rates <- min_median_rd_params(data = amphibian_nonoceanic_rates)

# get parameters
lambda_c <- amphibian_rates$value[amphibian_rates$params == "lambda_c"]
mu <- amphibian_rates$value[amphibian_rates$params == "mu"]
k <- amphibian_rates$value[amphibian_rates$params == "K"]
gamma <- amphibian_rates$value[amphibian_rates$params == "gamma"]
lambda_a <- amphibian_rates$value[amphibian_rates$params == "lambda_a"]
prob_init_pres <- amphibian_rates$value[amphibian_rates$params == "prob_init_pres"]

# simulate with amphibian MLE estimates
amphibian <- DAISIE::DAISIE_sim_cr(
  time = 88,
  M = 200,
  pars = c(lambda_c, mu, k, gamma, lambda_a),
  replicates = 1000,
  divdepmodel = "CS",
  nonoceanic_pars = c(prob_init_pres, 0),
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

# squamates

# load collated DAISIE MLE estimates
squamate_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squa_daisie_output",
    "squa_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

# calculate median rates
squamate_rates <- min_median_rd_params(data = squamate_nonoceanic_rates)

# get parameters
lambda_c <- squamate_rates$value[squamate_rates$params == "lambda_c"]
mu <- squamate_rates$value[squamate_rates$params == "mu"]
k <- squamate_rates$value[squamate_rates$params == "K"]
gamma <- squamate_rates$value[squamate_rates$params == "gamma"]
lambda_a <- squamate_rates$value[squamate_rates$params == "lambda_a"]
prob_init_pres <- squamate_rates$value[squamate_rates$params == "prob_init_pres"]

# simulate with squamate MLE estimates
squamate <- DAISIE::DAISIE_sim_cr(
  time = 88,
  M = 600,
  pars = c(lambda_c, mu, k, gamma, lambda_a),
  replicates = 1000,
  divdepmodel = "CS",
  nonoceanic_pars = c(prob_init_pres, 0),
  sample_freq = 176,
  verbose = TRUE
)

plot_sim <- DAISIE:::DAISIE_convert_to_classic_plot(
  simulation_outputs = squamate
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

# birds

# load collated DAISIE MLE estimates
bird_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "bird_daisie_output",
    "bird_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

# calculate median rates
bird_rates <- min_median_rd_params(data = bird_nonoceanic_rates)

# get parameters
lambda_c <- bird_rates$value[bird_rates$params == "lambda_c"]
mu <- bird_rates$value[bird_rates$params == "mu"]
k <- bird_rates$value[bird_rates$params == "K"]
gamma <- bird_rates$value[bird_rates$params == "gamma"]
lambda_a <- bird_rates$value[bird_rates$params == "lambda_a"]
prob_init_pres <- bird_rates$value[bird_rates$params == "prob_init_pres"]

# simulate with bird MLE estimates
bird <- DAISIE::DAISIE_sim_cr(
  time = 88,
  M = 1000,
  pars = c(lambda_c, mu, k, gamma, lambda_a),
  replicates = 1000,
  divdepmodel = "CS",
  nonoceanic_pars = c(prob_init_pres, 0),
  sample_freq = 176,
  verbose = TRUE
)

plot_sim <- DAISIE:::DAISIE_convert_to_classic_plot(
  simulation_outputs = bird
)
plot_sim <- plot_sim$all_species
plot_tbl <- rbind(
  plot_tbl,
  data.frame(
    taxonomic_group = rep("bird", length(plot_sim$stt_average[, "Time"])),
    time = plot_sim$stt_average[, "Time"],
    num_spec = plot_sim$stt_average[, "Total"] + 1,
    upper_quantile = plot_sim$stt_q0.975[, "Total"] + 1,
    lower_quantile = plot_sim$stt_q0.025[, "Total"] + 1
  )
)

# nonvolant mammals

# load collated DAISIE MLE estimates
nonvolant_mammal_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "nvm_daisie_output",
    "nvm_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

# calculate median rates
nonvolant_mammal_rates <- min_median_rd_params(data = nonvolant_mammal_nonoceanic_rates)

# get parameters
lambda_c <- nonvolant_mammal_rates$value[nonvolant_mammal_rates$params == "lambda_c"]
mu <- nonvolant_mammal_rates$value[nonvolant_mammal_rates$params == "mu"]
k <- nonvolant_mammal_rates$value[nonvolant_mammal_rates$params == "K"]
gamma <- nonvolant_mammal_rates$value[nonvolant_mammal_rates$params == "gamma"]
lambda_a <- nonvolant_mammal_rates$value[nonvolant_mammal_rates$params == "lambda_a"]
prob_init_pres <- nonvolant_mammal_rates$value[nonvolant_mammal_rates$params == "prob_init_pres"]

# simulate with non-volant mammal MLE estimates
nonvolant_mammal <- DAISIE::DAISIE_sim_cr(
  time = 88,
  M = 500,
  pars = c(lambda_c, mu, k, gamma, lambda_a),
  replicates = 1000,
  divdepmodel = "CS",
  nonoceanic_pars = c(prob_init_pres, 0),
  sample_freq = 176,
  verbose = TRUE
)

plot_sim <- DAISIE:::DAISIE_convert_to_classic_plot(
  simulation_outputs = nonvolant_mammal
)
plot_sim <- plot_sim$all_species
plot_tbl <- rbind(
  plot_tbl,
  data.frame(
    taxonomic_group = rep("nonvolant_mammal", length(plot_sim$stt_average[, "Time"])),
    time = plot_sim$stt_average[, "Time"],
    num_spec = plot_sim$stt_average[, "Total"] + 1,
    upper_quantile = plot_sim$stt_q0.975[, "Total"] + 1,
    lower_quantile = plot_sim$stt_q0.025[, "Total"] + 1
  )
)

# volant mammals

# load collated DAISIE MLE estimates
volant_mammal_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "vm_daisie_output",
    "vm_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

# calculate median rates
volant_mammal_rates <- min_median_rd_params(data = volant_mammal_nonoceanic_rates)

# get parameters
lambda_c <- volant_mammal_rates$value[volant_mammal_rates$params == "lambda_c"]
mu <- volant_mammal_rates$value[volant_mammal_rates$params == "mu"]
k <- volant_mammal_rates$value[volant_mammal_rates$params == "K"]
gamma <- volant_mammal_rates$value[volant_mammal_rates$params == "gamma"]
lambda_a <- volant_mammal_rates$value[volant_mammal_rates$params == "lambda_a"]
prob_init_pres <- volant_mammal_rates$value[volant_mammal_rates$params == "prob_init_pres"]

# simulate with volant mammal MLE estimates
volant_mammal <- DAISIE::DAISIE_sim_cr(
  time = 88,
  M = 100,
  pars = c(lambda_c, mu, k, gamma, lambda_a),
  replicates = 1000,
  divdepmodel = "CS",
  nonoceanic_pars = c(prob_init_pres, 0),
  sample_freq = 176,
  verbose = TRUE
)

plot_sim <- DAISIE:::DAISIE_convert_to_classic_plot(
  simulation_outputs = volant_mammal
)
plot_sim <- plot_sim$all_species
plot_tbl <- rbind(
  plot_tbl,
  data.frame(
    taxonomic_group = rep("volant_mammal", length(plot_sim$stt_average[, "Time"])),
    time = plot_sim$stt_average[, "Time"],
    num_spec = plot_sim$stt_average[, "Total"] + 1,
    upper_quantile = plot_sim$stt_q0.975[, "Total"] + 1,
    lower_quantile = plot_sim$stt_q0.025[, "Total"] + 1
  )
)

stt_plot <- ggplot2::ggplot(data = plot_tbl) +
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
    alpha = 0.5
  ) +
  ggplot2::facet_wrap(
    facets = "taxonomic_group",
    ncol = 3
  ) +
  ggplot2::scale_y_continuous(
    name = "Number of Island Species",
    trans = "log",
    breaks = scales::breaks_log()
  ) +
  ggplot2::scale_x_continuous(
    name = "Time (Million years ago)",
    trans = "reverse"
  ) +
  ggplot2::scale_fill_manual(
    name = "Taxonomic group",
    labels = c(
      amphibian = "Amphibians",
      nonvolant_mammal = "NV Mammals",
      volant_mammal = "V Mammals",
      squamate = "Squamates",
      bird = "Birds"
    ),
    values = c("#7fbd2d", "#073dfd", "#a8856e", "#01783f", "#3d3d3d")
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(
    strip.background = ggplot2::element_blank(),
    strip.text = ggplot2::element_blank(),
    legend.position = c(0.8, 0.2)
  )

ggplot2::ggsave(
  plot = stt_plot,
  filename = file.path(
    "inst",
    "plots",
    "stt_dna.png"
  ),
  device = "png",
  width = 150,
  height = 100,
  units = "mm",
  dpi = 300
)

ggplot2::ggsave(
  plot = stt_plot,
  filename = file.path(
    "inst",
    "plots",
    "stt_dna.svg"
  ),
  device = "svg",
  width = 150,
  height = 100,
  units = "mm",
  dpi = 300
)
