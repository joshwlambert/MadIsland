test_that("checklist_stats works as expected for amphibians", {

  amphibians <- read_checklist(file_name = "amphibian_checklist.csv")
  stats <- checklist_stats(amphibians)
  expect_type(stats, "list")
  expect_length(stats, 13)
  expect_named(
    stats,
    c("num_species", "num_genera", "num_families", "num_orders",
      "num_species_sampled", "num_species_dna_sampled", "num_extant_species",
      "num_extinct_species", "num_species_removed", "num_endemic_species",
      "num_daisie_endemic_species", "num_nonendemic_species",
      "num_daisie_nonendemic_species")
  )
})

test_that("checklist_stats works as expected for birds", {

  birds <- read_checklist(file_name = "bird_checklist.csv")
  stats <- checklist_stats(birds)
  expect_type(stats, "list")
  expect_length(stats, 13)
  expect_named(
    stats,
    c("num_species", "num_genera", "num_families", "num_orders",
      "num_species_sampled", "num_species_dna_sampled", "num_extant_species",
      "num_extinct_species", "num_species_removed", "num_endemic_species",
      "num_daisie_endemic_species", "num_nonendemic_species",
      "num_daisie_nonendemic_species")
  )
})

test_that("checklist_stats works as expected for non-volant mammals", {

  nonvolant_mammals <- read_checklist(file_name = "nonvolant_mammal_checklist.csv")
  stats <- checklist_stats(nonvolant_mammals)
  expect_type(stats, "list")
  expect_length(stats, 13)
  expect_named(
    stats,
    c("num_species", "num_genera", "num_families", "num_orders",
      "num_species_sampled", "num_species_dna_sampled", "num_extant_species",
      "num_extinct_species", "num_species_removed", "num_endemic_species",
      "num_daisie_endemic_species", "num_nonendemic_species",
      "num_daisie_nonendemic_species")
  )
})

test_that("checklist_stats works as expected for volant mammals", {

  volant_mammals <- read_checklist(file_name = "volant_mammal_checklist.csv")
  stats <- checklist_stats(volant_mammals)
  expect_type(stats, "list")
  expect_length(stats, 13)
  expect_named(
    stats,
    c("num_species", "num_genera", "num_families", "num_orders",
      "num_species_sampled", "num_species_dna_sampled", "num_extant_species",
      "num_extinct_species", "num_species_removed", "num_endemic_species",
      "num_daisie_endemic_species", "num_nonendemic_species",
      "num_daisie_nonendemic_species")
  )
})

test_that("checklist_stats works as expected for squamates", {

  squamates <- read_checklist(file_name = "squamate_checklist.csv")
  stats <- checklist_stats(squamates)
  expect_type(stats, "list")
  expect_length(stats, 13)
  expect_named(
    stats,
    c("num_species", "num_genera", "num_families", "num_orders",
      "num_species_sampled", "num_species_dna_sampled", "num_extant_species",
      "num_extinct_species", "num_species_removed", "num_endemic_species",
      "num_daisie_endemic_species", "num_nonendemic_species",
      "num_daisie_nonendemic_species")
  )
})

