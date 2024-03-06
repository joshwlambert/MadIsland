#summarise amphibian daisie rates dna data
amphibian_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "amp_daisie_output",
    "amp_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = amphibian_nonoceanic_rates)
min_median_rd_params(data = amphibian_nonoceanic_rates)

#summarise bird daisie rates DNA data
bird_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "bird_daisie_output",
    "bird_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = bird_nonoceanic_rates)
min_median_rd_params(data = bird_nonoceanic_rates)

#summarise nonvolant mammal daisie rates dna data
nonvolant_mammal_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "nvm_daisie_output",
    "nvm_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = nonvolant_mammal_nonoceanic_rates)
min_median_rd_params(data = nonvolant_mammal_nonoceanic_rates)

#summarise squamate daisie rates dna data
squamate_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "squa_daisie_output",
    "squa_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = squamate_nonoceanic_rates)
min_median_rd_params(data = squamate_nonoceanic_rates)

#summarise volant mammal daisie rates dna data
volant_mammal_nonoceanic_rates <- readRDS(
  file = system.file(
    "extdata",
    "collated_daisie_output",
    "vm_daisie_output",
    "vm_dna_nonoceanic.rds",
    package = "MadIsland",
    mustWork = TRUE
  )
)

summarise_daisie_rates(data = volant_mammal_nonoceanic_rates)
min_median_rd_params(data = volant_mammal_nonoceanic_rates)
