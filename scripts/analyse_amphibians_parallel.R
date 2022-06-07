# this script is to run fit the DAISIE models to the amphibian data on the
# Peregrine High Performance Cluster Computer (HPCC) at the University of
# Groningen

# read in arguments from command line
args <- commandArgs(TRUE)

# set array index as numeric
i <- as.numeric(args[2])

# before running this script the extract_amphibians script must be run to
# create the data to be input in the models

# load amphibian_daisie_data_list
daisie_data_list_complete <- readRDS(
  file = system.file(
    "extdata",
    "amphibian_daisie_data_list_complete.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

# run DAISIE model
DAISIEutils::run_daisie_ml(
  data = daisie_data_list_complete[[i]],
  data_name = "amphibian_complete",
  model = "cr_dd",
  array_index = 1,
  cond = 0,
  optimmethod = "simplex",
  low_rates = TRUE
)
