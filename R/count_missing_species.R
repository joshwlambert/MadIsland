#' Reads in the checklist of all species on an island, including those that are
#' not in the phylogeny (represented by NA) and counts the number of species
#' missing from the phylogeny each genus
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame
#' @export
#'
#' @examples
#' count_missing_species(file_name = "mammal_checklist.csv")
count_missing_species <- function(file_name) {

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
    header = TRUE,
    sep = ";"
  )

  # Naming convention is the raw data column names are underscore separated
  # title case, when the data is modified in memory (i.e. in R) data column
  # names are underscore separated lowercase

  not_in_tree <- which(is.na(tbl$Name_In_Tree))
  missing_genus <- tbl[not_in_tree, "Genus"]

  missing_species <- table(missing_genus)

  missing_species <- as.data.frame(missing_species)

  colnames(missing_species) <- c("clade_name", "missing_species")

  # return missing species data frame
  missing_species
}
