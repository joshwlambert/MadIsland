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
#' @param dna_or_complete A character string, either "DNA" or "complete" (case
#' insensitive) to determine whether to produce data for the DNA-only phylogeny
#' or the complete phylogeny
#' @param checklist_file_name Character string with the name of the checklist
#' file (and its file extension) to load
#' @param phylo_file_name Character string with the name of the phylogenetic
#' data (and its file extension) to load
#' @param daisie_status Boolean determining whether to use the true endemicity
#' status or the augmented endemicity status, called the daisie status, which
#' adjusts for species that are a product of the island processes but have since
#' migrated
#' @param extraction_method Character string, either "min" or "asr" determining
#' whether to use the `min` or `asr` algorithms for the
#' `DAISIEprep::extract_island_species()` extraction process, see `DAISIEprep`
#' documentation for more information.
#'
#' @return Nothing
#' @keywords internal
#' @export
default_params_doc <- function(bar,
                               file_name,
                               checklist,
                               island_tbl,
                               missing_species,
                               missing_genus,
                               dna_or_complete,
                               checklist_file_name,
                               phylo_file_name,
                               daisie_status,
                               extraction_method) {
  #Nothing
}
