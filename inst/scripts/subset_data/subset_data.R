args <- commandArgs(TRUE)

args <- as.numeric(args)

if (length(args) != 1) {
  stop("only one argument can be specified")
}

mammal_data <- readRDS(file = system.file(
  "extdata",
  "extracted_data",
  "mammal_data",
  "mammal_daisie_data_list_complete_asr.rds",
  package = "MadIsland",
  mustWork = TRUE
))

data_name <- paste("mammal_data", args, sep = "_")

assign(
  x = data_name,
  value = mammal_data[[args]]
)

if (isFALSE(dir.exists(file.path(getwd(), "data")))) {
  dir.create("data")
}

file_path <- file.path(getwd(), "data", paste0(data_name, ".rda"))
save(list = data_name, file = file_path)
