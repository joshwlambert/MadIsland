#' Calculates summary statistics for the checklists
#'
#' @param checklist An island species checklist
#'
#' @return A list of summary stats
#' @export
checklist_stats <- function(checklist) {

  # return list of summary stats
  list(

    # number of species in checklist
    num_species = nrow(checklist),

    # number of genera in checklist
    num_genera = length(unique(checklist$Genus)),

    # number of families in checklist
    num_families = length(unique(checklist$Family)),

    # number of orders in checklist
    num_orders = length(unique(checklist$Order)),

    # number of species in checklist sampled in phylogeny
    num_species_sampled = sum(checklist$Sampled),

    # number of species in checklist sampled in phylogeny with DNA
    num_species_dna_sampled = sum(checklist$DNA_In_Tree),

    # number of extant species in checklist
    num_extant_species = sum(grepl(
      pattern = "Extant", x = checklist$Extinct_Extant, ignore.case = TRUE
    )),

    # number of extinct species in checklist
    num_extinct_species = sum(grepl(
      pattern = "Extinct", x = checklist$Extinct_Extant, ignore.case = TRUE
    )),

    # number of species in checklist removed due to not be true island species
    num_species_removed = sum(checklist$Remove_Species),

    # number of endemic species in checklist
    # true endemicity
    num_endemic_species = sum(grepl(
      pattern = "Endemic", x = checklist$Status_Species, ignore.case = TRUE
    )),
    # DAISIE endemicity
    num_daisie_endemic_species = sum(grepl(
      pattern = "Endemic",
      x = checklist$DAISIE_Status_Species,
      ignore.case = TRUE
    )),

    # number of non-endemic species in checklist
    # true endemicity
    num_nonendemic_species = sum(grepl(
      pattern = "Non-endemic", x = checklist$Status_Species, ignore.case = TRUE
    )),
    # DAISIE endemicity
    num_daisie_nonendemic_species = sum(grepl(
      pattern = "Non-endemic",
      x = checklist$DAISIE_Status_Species,
      ignore.case = TRUE
    ))
  )
}

