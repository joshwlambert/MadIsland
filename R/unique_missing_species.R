#' Title
#'
#' @inheritParams default_params_doc
#'
#' @return list of character vectors
#' @export
#'
#' @examples
unique_missing_species <- function(island_tbl) {

  # convert island_tbl to data frame
  island_tbl <- DAISIEprep::get_island_tbl(island_tbl)

  # add missing species to each island table
  island_tbl_split_names <- lapply(island_tbl$species, strsplit, split = "_")
  island_tbl_genus_names <- lapply(island_tbl_split_names, function(x) {
    lapply(x, "[[", 1)
  })
  island_tbl_genus_names <- lapply(island_tbl_genus_names, unlist)

  # are there any genera that are found separate clades
  # when a duplicate genus is found the first one is kept
  # instead of keeping the first it could be assigned randomly

  # get unique genera from each clade
  genus_unique <- lapply(island_tbl_genus_names, unique)

  # make list that will contain unique genera
  missing_genus <- genus_unique
  # take set difference between contents of list elements and accumulated
  # elements
  missing_genus[-1] <- mapply(
    setdiff,
    missing_genus[-1],
    head(Reduce(c, genus_unique, accumulate=TRUE), -1)
  )

  # return missing_genus
  missing_genus
}
