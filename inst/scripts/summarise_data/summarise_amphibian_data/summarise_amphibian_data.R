# summarise amphibian island community data

amphibians <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "amphibian_data",
  "amphibian_island_tbl_complete_ds_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

# calculate mean and sd maximum (oldest) colonisation time across each posterior
col_times <- lapply(amphibians, \(x) {x@island_tbl$col_time})
max_col_time <- unlist(lapply(col_times, max))
mean_max_col_time <- mean(max_col_time)
sd_max_col_time <- stats::sd(max_col_time)
mean_max_col_time
sd_max_col_time

# calculate mean and sd minimum (youngest) colonisation time across each posterior
min_col_time <- unlist(lapply(col_times, min))
mean_min_col_time <- mean(min_col_time)
sd_min_col_time <- stats::sd(min_col_time)
mean_min_col_time
sd_min_col_time

# calculate mean and sd number of colonisation event across each posterior
num_col <- unlist(lapply(amphibians, \(x) {nrow(x@island_tbl)}))
mean_num_col <- mean(num_col)
sd_num_col <- stats::sd(num_col)
mean_num_col
sd_num_col


# calculate the mean and sd for the largest island clade across each posterior

# number of species is 1 when there are no branching times (NA) and branching
# times plus 1 when there are branching times
clade_size <- lapply(amphibians, \(x) {
  unlist(lapply(x@island_tbl$branching_times, \(y) {
    if(is.na(y[1])) 1 else length(y) + 1
  }))
})
max_clade_size <- unlist(lapply(clade_size, max))
mean_max_clade_size <- mean(max_clade_size)
sd_max_clade_size <- stats::sd(max_clade_size)
mean_max_clade_size
sd_max_clade_size

# calculate the mean and sd for the smallest island clade across each posterior
min_clade_size <- unlist(lapply(clade_size, min))
mean_min_clade_size <- mean(min_clade_size)
sd_min_clade_size <- stats::sd(min_clade_size)
mean_min_clade_size
sd_min_clade_size

# calculate the mean and sd for the percentage endemism across each posterior
status <- lapply(amphibians, \(x) {x@island_tbl$status})
status_per_species <- mapply(rep, status, clade_size)
percent_endemic <- unlist(lapply(status_per_species, \(x) {
  sum(x == "endemic") / (sum(x != "endemic") + sum(x == "endemic")) * 100
}))
mean_percent_endemic <- mean(percent_endemic)
sd_percent_endemic <- stats::sd(percent_endemic)
mean_percent_endemic
sd_percent_endemic
