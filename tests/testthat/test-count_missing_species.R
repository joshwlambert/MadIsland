test_that("count_missing_species works for non-volant mammals", {
  mammal_checklist <- read_checklist(
    file_name = "nonvolant_mammal_checklist.csv"
  )
  missing_mammals <- count_missing_species(
    checklist = mammal_checklist,
    dna_or_complete = "dna",
    daisie_status = TRUE
  )
  expect_true(is.data.frame(missing_mammals))
  expect_equal(ncol(missing_mammals), 3)
  expect_equal(nrow(missing_mammals), 28)
  expect_equal(
    colnames(missing_mammals),
    c("clade_name", "missing_species", "endemicity_status")
  )
})
