test_that("process_raw_data works with ", {
  data <- process_raw_data(file_name = "mammal_checklist.csv")
  expect_true(is.data.frame(data))
  expect_equal(colnames(data), c("tip_labels", "tip_endemicity_status"))
  expect_equal(nrow(data), 215)
})
