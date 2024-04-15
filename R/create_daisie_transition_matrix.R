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
#' endemics. Island extinction (state 3 and state 2 to state 1) are constrained
#' to the same rate, back-colonisation from the island (state 3 to state 2)
#' is given its own rate, as is anagenesis (state 2 to state 3).
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
        2, 4, 0
      ),
      nrow = 3,
      byrow = TRUE
    )
  )
}
