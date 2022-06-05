add_phylo_missing_species <- function(missing_species,
                                      missing_genus,
                                      island_tbl) {

  for (i in seq_along(missing_genus)) {
    which_species <- which(
      missing_species$clade_name %in% missing_genus[[i]]
    )

    # if that clade contains a genus that has missing species then add missing
    # species to island_tbl
    if (length(which_species) > 0) {
      phylo_missing_species <- missing_species[which_species, ]

      # sum up number of missing species if there are multiple genera in a clade
      phylo_missing_species <- data.frame(
        clade_name = island_tbl@island_tbl$clade_name[i],
        missing_species = sum(phylo_missing_species$missing_species)
      )

      # add the number of missing species to the island tbl for those that have been
      # extracted already
      island_tbl <- DAISIEprep::add_missing_species(
        island_tbl = island_tbl,
        missing_species_df = phylo_missing_species
      )
    }
  }

  # return island_tbl
  island_tbl
}
