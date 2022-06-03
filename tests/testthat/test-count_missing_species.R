test_that("count_missing_species works for mammals", {
  missing_mammals <- count_missing_species(file_name = "mammal_checklist.csv")
  expect_true(is.data.frame(missing_mammals))
  expect_equal(ncol(missing_mammals), 2)
  expect_equal(nrow(missing_mammals), 21)
  expect_equal(colnames(missing_mammals), c("clade_name", "missing_species"))
})
