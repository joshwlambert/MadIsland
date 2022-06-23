# before running this script the extract_mammals_complete_asr script must be
# run to create the data to be input in the models

# load amphibian_daisie_data_list
daisie_data_list_complete <- readRDS(
  file = system.file(
    "extdata",
    "extracted_data",
    "mammal_data",
    "mammal_daisie_data_list_complete.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)


DAISIEutils::run_daisie_ml(
  data = data[[1]],
  data_name = "mammal_complete_asr",
  model = "cr_dd",
  array_index = 1,
  cond = 0)


grep(
  pattern = "data_list",
  x = list.files(path = system.file(
    "extdata",
    "extracted_data",
    "mammal_data",
    package = "MadIsland"
  )),
  value = TRUE
)

