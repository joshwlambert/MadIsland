#' Read a checklist into R given a file name
#'
#' @inheritParams default_params_doc
#'
#' @return Data frame
#' @export
#'
#' @examples
#' read_checklist(file_name = "volant_mammal_checklist.csv")
read_checklist <- function(file_name){

  # check that a single csv file name is input
  if (!all(grepl(pattern = ".csv", x = file_name)) || length(file_name) != 1) {
    stop("This function processes a single csv file")
  }

  # generate file path from file_name input
  file_path <- file.path("extdata", "checklists", file_name)

  # read csv
  tbl <- utils::read.csv(
    file = system.file(
      file_path,
      package = "MadIsland",
      mustWork = TRUE
    ),
    header = TRUE,
  )

  # return checklist
  tbl
}
