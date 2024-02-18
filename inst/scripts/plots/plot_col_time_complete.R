amphibians <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "amp_data",
  "amp_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

nonvolant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "nvm_data",
  "nvm_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

volant_mammals <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "vm_data",
  "vm_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

squamates <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "squa_data",
  "squa_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

birds <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "bird_data",
  "bird_it_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

multi_island_tbl_list <- list(
  Amphibians = amphibians,
  Nonvolant_Mammals = nonvolant_mammals,
  Volant_Mammals = volant_mammals,
  Squamates = squamates,
  Birds = birds
)


stem_col_time <- plot_col_island_tbl(
  multi_island_tbl_list = multi_island_tbl_list,
  col_time = "stem"
)

ggplot2::ggsave(
  plot = stem_col_time,
  filename = file.path(
    "inst",
    "plots",
    "stem_col_time_complete.png"
  ),
  device = "png",
  width = 150,
  height = 100,
  units = "mm",
  dpi = 300
)

crown_col_time <- plot_col_island_tbl(
  multi_island_tbl_list = multi_island_tbl_list,
  col_time = "crown"
)

ggplot2::ggsave(
  plot = crown_col_time,
  filename = file.path(
    "inst",
    "plots",
    "crown_col_time_complete.png"
  ),
  device = "png",
  width = 150,
  height = 100,
  units = "mm",
  dpi = 300
)
