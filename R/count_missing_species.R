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
count_missing_species <- function(checklist,
                                  dna_or_complete) {

  # Naming convention is the raw data column names are underscore separated
  # title case, when the data is modified in memory (i.e. in R) data column
  # names are underscore separated lowercase

  if (grepl(pattern = "dna", x = dna_or_complete, ignore.case = TRUE)) {
    not_in_tree <- which(!checklist$DNA_In_Tree)
  } else {
    not_in_tree <- which(!checklist$Sampled)
  }

  missing_genus <- checklist[not_in_tree, "Genus"]

  missing_species <- table(missing_genus)

  missing_species <- as.data.frame(missing_species)

  missing_species$missing_genus <- as.character(missing_species$missing_genus)

  colnames(missing_species) <- c("clade_name", "missing_species")

  # return missing species data frame
  missing_species
}
