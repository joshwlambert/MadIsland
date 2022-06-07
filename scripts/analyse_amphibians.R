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
ml_complete <- list()
for (i in seq_along(daisie_data_list_complete)) {
  message(
    "Fitting DAISIE model to data set ", i, " of ", length(daisie_data_list_complete)
  )

  DAISIEutils::run_daisie_ml(
    data = daisie_data_list_complete[[i]],
    data_name = "amphibian_complete",
    model = "cr_dd",
    array_index = 1,
    cond = 0,
    optimmethod = "subplex"
  )


  ml_complete[[i]] <- DAISIE::DAISIE_ML_CS(
    datalist = daisie_data_list_complete[[i]],
    initparsopt = c(1, 1, 200, 0.1, 1),
    idparsopt = 1:5,
    parsfix = NULL,
    idparsfix = NULL,
    ddmodel = 11,
    jitter = 1e-5
  )
}


