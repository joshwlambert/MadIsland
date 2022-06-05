#' Documentation to be inherited by other functions in the package
#'
#' @param bar temporary argument name
#' @param file_name character string with the file name, including the file
#' extension (needs to be .csv)
#' @param checklist data frame with information on species on the island
#' @param island_tbl Object of Island_tbl class from DAISIEprep package
#' @param missing_species A two column data frame of genera with missing species
#' and the number of missing species
#' @param missing_genus A list of character vectors containing the genera in
#' each island clade
#'
#' @return Nothing
#' @keywords internal
#' @export
default_params_doc <- function(bar,
                               file_name,
                               checklist,
                               island_tbl,
                               missing_species,
                               missing_genus) {
  #Nothing
}
