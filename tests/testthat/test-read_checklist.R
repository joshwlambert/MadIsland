test_that("read_checklist works", {
  checklist <- read_checklist(file_name = "mammal_checklist.csv")
  expect_true(is.data.frame(checklist))
  expect_equal(nrow(checklist), 249)
  expect_equal(ncol(checklist), 13)
  expect_equal(
    colnames(checklist),
    c("Genus", "Species", "Subspecies", "Family", "Order", "Common_Name",
      "Name_In_Tree", "Sampled", "DNA_In_Tree", "Extinct_Extant",
      "Status_Species", "DAISIE_Status_Species", "Remove_Species")
  )
})

test_that("read_checklist fails with incorrect file name", {
  expect_error(read_checklist(file_name = "donkey_checklist.csv"))
})
