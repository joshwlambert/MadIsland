# get the amphibian collated DAISIE output for DNA data
amphibian <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amp_daisie_output",
    "amp_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

amphibian_k <- amphibian[amphibian$params == "K", ]
amphibian_k$taxonomic_group <- "amphibian"

squamate <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squa_daisie_output",
    "squa_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

squamate_k <- squamate[squamate$params == "K", ]
squamate_k$taxonomic_group <- "squamate"

nvm <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "nvm_daisie_output",
    "nvm_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

nvm_k <- nvm[nvm$params == "K", ]
nvm_k$taxonomic_group <- "nvm"

vm <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "vm_daisie_output",
    "vm_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

vm_k <- vm[vm$params == "K", ]
vm_k$taxonomic_group <- "vm"

bird <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "bird_daisie_output",
    "bird_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

bird_k <- bird[bird$params == "K", ]
bird_k$taxonomic_group <- "bird"

k_tbl <- rbind(amphibian_k, squamate_k, nvm_k, vm_k, bird_k)
k_tbl$taxonomic_group <- factor(k_tbl$taxonomic_group)

# set any values greater than 1,000 to infinite for plotting purposes as these
# values can be considered diversity-independent in reality
num_inf_k <- data.frame(amphibian = 0, bird = 0, nvm = 0, vm = 0, squamate = 0)
max_k <- 1000
for (i in seq_len(nrow(k_tbl))) {
  k <- ifelse(test = is.na(k_tbl$value[i]), yes = Inf, no = k_tbl$value[i])
  if (k > max_k) {
    taxa <- as.character(k_tbl$taxonomic_group[i])
    num_inf_k[, taxa] <- num_inf_k[, taxa] + 1
  }
}
# tidy data into long form
num_inf_k <- data.frame(
  taxonomic_group = colnames(num_inf_k),
  count = unlist(as.vector(num_inf_k))
)

k_tbl_finite <- k_tbl
k_tbl_finite$value[k_tbl$value >= max_k] <- max_k
k_tbl_finite <- k_tbl_finite[k_tbl_finite$value < max_k, ]

k_plot_dna <- ggplot2::ggplot(data = k_tbl_finite) +
  ggplot2::geom_histogram(
    mapping = ggplot2::aes(
      x = value,
      fill = taxonomic_group
    ),
    alpha = 0.75,
    position = "identity",
    binwidth = 25
  ) +
  ggplot2::scale_x_continuous(
    name = "Carrying Capacity (K')",
    limits = c(0, max_k)
  ) +
  ggplot2::scale_y_continuous(name = "Count") +
  ggplot2::scale_fill_manual(
    labels = c("Amphibian", "Birds", "Squamate"),
    values = c("#7fbd2d", "#073dfd", "#01783f"),
    guide = ggplot2::guide_legend("Taxonomic Group")
  ) +
  ggplot2::theme_classic()


k_plot_dna_inset <- ggplot2::ggplot(data = num_inf_k) +
  ggplot2::geom_col(
    mapping = ggplot2::aes(
      x = taxonomic_group,
      y = count,
      fill = taxonomic_group
    )
  ) +
  ggplot2::scale_x_discrete(
    name = "Taxonomic Group",
    labels = c(
      "Amphibians", "Birds", "Non-volant Mammals", "Squamates", "Volant Mammals"
    ), guide = ggplot2::guide_axis(n.dodge = 2)
  ) +
  ggplot2::scale_y_continuous(name = "Count K' > 1,000") +
  ggplot2::scale_fill_manual(
    values = c("#7fbd2d", "#073dfd", "#a8856e", "#01783f", "#3d3d3d")
  ) +
  ggplot2::theme_classic() +
  ggplot2::theme(legend.position = "none")

k_plot_dna <- cowplot::ggdraw(k_plot_dna) +
  cowplot::draw_plot(k_plot_dna_inset, 0.375, 0.6, 0.4, 0.4)

ggplot2::ggsave(
  plot = k_plot_dna,
  filename = file.path(
    "inst",
    "plots",
    "k_plot_dna.png"
  ),
  device = "png",
  width = 250,
  height = 200,
  units = "mm",
  dpi = 300
)

