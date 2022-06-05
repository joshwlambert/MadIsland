rm_phylo_missing_species <- function(missing_species,
                                     missing_genus) {

  for (i in seq_along(missing_genus)) {
    which_species <- which(
      missing_amphibian_species$clade_name %in% missing_genus[[i]]
    )

    # if that clade contains a genus that has missing species then add missing
    # species to island_tbl
    if (length(which_species) > 0) {

      # delete rows from missing_amphibian_species
      missing_amphibian_species <- missing_amphibian_species[-which_species, ]
    }
  }
}
