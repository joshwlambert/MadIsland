#' Wrapper function for reading in data, processing raw dat, counting number of
#' missing species, formatting data, extracting island data, inputting missing
#' species that have phylogenetic data and outputting the island data, the
#' missing species that have not been assigned and the phylogenetic data used
#' to extract the species.
#'
#' @inheritParams default_params_doc
#'
#' @return List with:
#'   * `multi_island_tbl`, the island community data
#'   * `phylods`, the phylogenetic data with associated endemicity data
#'   * `no_island_tbl_missing_species`, the species that have not been assigned to
#'   the island community data
#' @export
extract_species <- function(checklist_file_name,
                            phylo_file_name,
                            dna_or_complete,
                            daisie_status,
                            extraction_method) {

  # load the full raw data checklist of bird species of madagascar
  checklist <- read_checklist(file_name = checklist_file_name)

  # creates the endemicity status data from the checklist data
  island_endemicity_status <- process_raw_data(
    file_name = checklist_file_name,
    dna_or_complete = dna_or_complete,
    daisie_status = daisie_status
  )

  # check that the data has loaded correctly and that it has the correct data
  col_names <- c(
    "Genus", "Species", "Subspecies", "Family", "Order", "Common_Name",
    "Name_In_Tree", "Sampled", "DNA_In_Tree", "Extinct_Extant",
    "Status_Species", "DAISIE_Status_Species", "Remove_Species"
  )
  correct_colnames <- all(colnames(checklist) == col_names)
  if (isFALSE(correct_colnames)) {
    stop(paste(
      "Column names for the checklist are incorrect, they should be: ",
      col_names))
  }

  # count the number of missing species for each genus
  missing_species <- count_missing_species(
    checklist = checklist,
    dna_or_complete = dna_or_complete,
    daisie_status = daisie_status
  )

  # load the trees
  phylos <- readRDS(
    file = system.file(
      "extdata", "phylos", phylo_file_name,
      package = "MadIsland"
    )
  )

  # setup for future parallelisation
  future::plan(future::multisession)

  # convert trees to phylo4 objects
  phylos <- future.apply::future_lapply(
    phylos,
    phylobase::phylo4,
    future.seed = TRUE
  )

  # create endemicity status data frame
  endemicity_status <- future.apply::future_lapply(
    phylos,
    DAISIEprep::create_endemicity_status,
    island_species = island_endemicity_status,
    future.seed = TRUE
  )

  # combine tree and endemicity status
  phylods <- future.apply::future_mapply(
    phylobase::phylo4d,
    phylos,
    endemicity_status,
    future.seed = TRUE
  )

  if (extraction_method == "asr") {
    # reconstruct geographic ancestral states for extraction with asr
    phylods <- future.apply::future_lapply(
      phylods,
      DAISIEprep::add_asr_node_states,
      asr_method = "mk",
      tie_preference = "mainland",
      future.seed = TRUE
    )
  }

  # extract island community
  multi_island_tbl <- DAISIEprep::multi_extract_island_species(
    multi_phylod = phylods,
    extraction_method = extraction_method,
    verbose = TRUE
  )

  # determine which island clade the missing species should be assigned to
  missing_genus <- lapply(
    multi_island_tbl,
    DAISIEprep::unique_island_genera
  )

  # add missing species that match genera found in the island tbl
  multi_island_tbl <- mapply(
    DAISIEprep::add_multi_missing_species,
    missing_genus,
    multi_island_tbl,
    missing_species = list(missing_species)
  )

  # remove missing species that have already been inserted into the island tbl
  no_island_tbl_missing_species <- mapply(
    DAISIEprep::rm_multi_missing_species,
    missing_genus,
    multi_island_tbl,
    missing_species = list(missing_species),
    SIMPLIFY = FALSE
  )

  # check that all the missing species that have not already been assigned are
  # the same between different trees in the posterior
  missing_species_match <- c()
  for (i in seq_along(no_island_tbl_missing_species)) {
    missing_species_match[i] <- identical(
      no_island_tbl_missing_species[[i]]$clade_name,
      no_island_tbl_missing_species[[i + 1]]$clade_name
    )

    # cannot compute i + 1 when at the last element so stop at the last but one
    if (i == (length(no_island_tbl_missing_species) - 1)) {
      break
    }
  }

  if (isFALSE(all(missing_species_match))) {
    stop("There are different missing species from each posterior")
  }


  # return a list with a list of island_tbls and species that have not been
  # assigned to the island_tbl
  list(
    multi_island_tbl = multi_island_tbl,
    phylods = phylods,
    no_island_tbl_missing_species = no_island_tbl_missing_species
  )
}
