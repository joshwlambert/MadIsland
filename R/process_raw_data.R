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
                             dna_or_complete,
                             daisie_status) {

  tbl <- read_checklist(file_name = file_name)

  # Naming convention is the raw data column names are underscore separated
  # title case, when the data is modified in memory (i.e. in R) data column
  # names are underscore separated lowercase

  # remove species that are tagged as needing removal from the data set
  # likely as they are introduced (alien) to the island
  rm_species <- which(tbl$Remove_Species)
  if (length(rm_species) > 0) {
    tbl <- tbl[-rm_species, ]
  }

  # subset to name in the phylogeny and the endemicity status
  if (daisie_status) {
    # use endemicity status corrected for DAISIE
    island_species <- tbl[, c("Name_In_Tree", "DAISIE_Status_Species")]
  } else {
    # use true endemicity status
    island_species <- tbl[, c("Name_In_Tree", "Status_Species")]
  }


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
