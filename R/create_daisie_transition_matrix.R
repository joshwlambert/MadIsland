#' Create the transition matrix for the DAISIE data extraction using the
#' ASR algorithm
#'
#' @description
#' Creates a 3x3 matrix with the constraints on the ancestral state
#' reconstruction when fitting the Mk model ([castor::asr_mk_model()]) using
#' [DAISIEprep::add_asr_node_states()].
#'
#' The constraints are colonisation to the island is from state 1
#' (`not_present`) to state 2 (`nonendemic`) and species cannot colonise as
#' endemics. Island extinction is constrained to `nonendemic` to `not_present`
#' (state 2 to state 1), island extinction of `endemic` cannot happen (state 3
#' to state 1), back-colonisation from the island is not allowed (state 3 to
#' state 2), and anagenesis has its own rate (state 2 to state 3).
#'
#' @param ... [dots] Not used, warns if arguments are supplied.
#'
#' @return A 3x3 integer matrix.
#' @export
#'
#' @examples
#' create_daisie_transition_matrix
create_daisie_transition_matrix <- function(...) {
  chkDots(...)
  return(
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
}
