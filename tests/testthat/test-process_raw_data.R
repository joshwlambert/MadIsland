test_that("process_raw_data works with complete data", {
  data <- process_raw_data(
    file_name = "mammal_checklist.csv",
    dna_or_complete = "complete")
  expect_true(is.data.frame(data))
  expect_equal(colnames(data), c("tip_labels", "tip_endemicity_status"))
  expect_equal(nrow(data), 215)
})

test_that("process_raw_data works with DNA data", {
  data <- process_raw_data(
    file_name = "mammal_checklist.csv",
    dna_or_complete = "DNA")
  expect_true(is.data.frame(data))
  expect_equal(colnames(data), c("tip_labels", "tip_endemicity_status"))
  expect_equal(nrow(data), 154)
})
