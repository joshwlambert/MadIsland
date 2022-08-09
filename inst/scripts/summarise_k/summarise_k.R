# summarise number K plotted for complete data

# summarise number K plotted for dna data

# amphibians
amphibian <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

# keep carrying capacity
amphibian_k <- dplyr::filter(
  amphibian,
  params %in% c("K")
)

length(which(amphibian_k$value > 10000))

#squamates
squamate <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

squamate_k <- dplyr::filter(
  squamate,
  params %in% c("K")
)

length(which(squamate_k$value > 10000))

#birds
bird <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "bird_daisie_output",
    "bird_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

bird_k <- dplyr::filter(
  bird,
  params %in% c("K")
)

length(which(bird_k$value > 10000))

# non-volant mammals
nonvolant_mammal <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "nonvolant_mammal_daisie_output",
    "nonvolant_mammal_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

nonvolant_mammals_k <- dplyr::filter(
  nonvolant_mammal,
  params %in% c("K")
)

length(which(nonvolant_mammals_k$value > 10000))

# volant mammals
volant_mammal <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "volant_mammal_daisie_output",
    "volant_mammal_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

volant_mammals_k <- dplyr::filter(
  volant_mammal,
  params %in% c("K")
)

length(which(volant_mammals_k$value > 10000))
