#' Adds a specified number of missing species to an existing island_tbl at the
#' colonist specified by the species_name argument given. The species given is
#' located within the island_tbl data and missing species are assigned.
#'
#' @inheritParams default_params_doc
#'
#' @return Object of Island_tbl class (see DAISIEprep package)
#' @export
#'
#' @examples
#' \dontrun{"WIP"}
add_missing_species <- function(island_tbl,
                                num_missing_species,
                                species_name) {

  # find the specified species in the island tbl and locate index of colonist
  find_species <- lapply(
    island_tbl@island_tbl$species,
    function(x) {
      which_colonist <- grepl(pattern = species_name, x = x)
    }
  )
  colonist_index <- which(unlist(lapply(find_species, any)))

  # add number of missing species to the specified colonist
  island_tbl@island_tbl$missing_species[colonist_index] <-
    island_tbl@island_tbl$missing_species[colonist_index] +
    num_missing_species

  # return island_tbl
  island_tbl
}
