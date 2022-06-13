#' Processes raw data file (checklist of island species) which can contain
#' data on many aspects (e.g. phenotypic trait) down to a data file with only
#' the species names in the phylogeny and their endemicity status on the island
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame
#' @export
#'
#' @examples
#' data <- process_raw_data(
#'   file_name = "mammal_checklist.csv",
#'   dna_or_complete = "complete"
#' )
process_raw_data <- function(file_name,
                             dna_or_complete) {

  # check that a single csv file name is input
  if (!all(grepl(pattern = ".csv", x = file_name)) || length(file_name) != 1) {
    stop("This function processes a single csv file")
  }

  # generate file path from file_name input
  file_path <- file.path("extdata", file_name)

  # read csv
  tbl <- utils::read.csv(
    file = system.file(
      file_path,
      package = "MadIsland"
    ),
    header = TRUE
  )

  # Naming convention is the raw data column names are underscore separated
  # title case, when the data is modified in memory (i.e. in R) data column
  # names are underscore separated lowercase

  # subset to name in the phylogeny and the endemicity status
  island_species <- tbl[, c("Name_In_Tree", "Status_Species")]

  if (grepl(pattern = "dna", x = dna_or_complete, ignore.case = TRUE)) {
    dna_species <- which(tbl$DNA_In_Tree)
    island_species <- island_species[dna_species, ]
  }

  names(island_species) <- c("tip_labels", "tip_endemicity_status")

  # remove species that have NA in the data frame (most likely from not being in
  # the phylogeny)
  island_species <- stats::na.omit(island_species)

  # replace white space with underscores
  name_in_tree <- gsub(
    pattern = " ",
    replacement = "_",
    x = island_species$tip_labels
  )
  island_species$tip_labels <- name_in_tree

  status_species <- c()
  for (i in seq_along(island_species$tip_endemicity_status)) {
    status_species[i] <- DAISIEprep::translate_status(
      island_species$tip_endemicity_status[i]
    )
  }
  island_species$tip_endemicity_status <- status_species

  # return island species data frame
  island_species
}
