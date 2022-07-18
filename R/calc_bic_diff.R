calc_bic_diff <- function(oceanic_data,
                          nonoceanic_data) {

  oceanic_bic <- oceanic_data[which(oceanic_data$params == "bic"), ]
  nonoceanic_bic <- nonoceanic_data[which(nonoceanic_data$params == "bic"), ]

  bic_diff <- oceanic_bic$value - nonoceanic_bic$value

  # return vector of bic differences
  bic_diff
}
