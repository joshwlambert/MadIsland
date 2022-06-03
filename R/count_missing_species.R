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
#' mammal_checklist <- read_checklist(file_name = "mammal_checklist.csv")
#' count_missing_species(checklist = mammal_checklist)
count_missing_species <- function(checklist) {

  # Naming convention is the raw data column names are underscore separated
  # title case, when the data is modified in memory (i.e. in R) data column
  # names are underscore separated lowercase

  not_in_tree <- which(is.na(checklist$Name_In_Tree))
  missing_genus <- checklist[not_in_tree, "Genus"]

  missing_species <- table(missing_genus)

  missing_species <- as.data.frame(missing_species)

  missing_species$clade_name <- as.character(missing_species$clade_name)

  colnames(missing_species) <- c("clade_name", "missing_species")

  # return missing species data frame
  missing_species
}
