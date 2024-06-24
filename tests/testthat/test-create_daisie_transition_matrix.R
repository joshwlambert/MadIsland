test_that("create_daisie_transition_matrix works", {
  expect_identical(
    create_daisie_transition_matrix(),
    matrix(
      data = c(
        0, 1, 0,
        2, 0, 3,
        0, 0, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
})

test_that("create_daisie_transition_matrix works with zero endemic ext", {
  expect_identical(
    create_daisie_transition_matrix(zero_endemic_ext = FALSE),
    matrix(
      data = c(
        0, 1, 0,
        2, 0, 3,
        4, 0, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
})

test_that("create_daisie_transition_matrix works with zero endemic back col", {
  expect_identical(
    create_daisie_transition_matrix(zero_endemic_back_col = FALSE),
    matrix(
      data = c(
        0, 1, 0,
        2, 0, 3,
        0, 4, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
})
