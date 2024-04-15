test_that("create_daisie_transition_matrix works", {
  expect_identical(
    create_daisie_transition_matrix(),
    matrix(
      data = c(
        0, 1, 0,
        2, 0, 3,
        2, 4, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
})

test_that("create_daisie_transition_matrix warns", {
  expect_warning(create_daisie_transition_matrix("something"))
})
