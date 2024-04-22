#' Function reads in each of the DAISIE maximum likelihood outputs stored in the
#' specified results folder and extracts the best maximum likelihood optimisation
#' for each different phylogeny and stores it as tabular data
#'
#' @param results_dir A character string of the folder name in
#' inst/daisie_results to read the results from
#' @param oceanic_or_nonoceanic A character string, either "oceanic" or
#' "nonoceanic"
#' @param num_phylos Numeric of how many phylogenies were used
#'
#' @return tibble
#' @export
#'
#' @examples
#' # name of results of results folder
#' results_dir <- "amp_ddl_complete_ds_asr"
#' # number of phylogeny replicates used
#' num_phylos <- 3
#' # oceanic results
collate_daisie_output <- function(results_dir) {

  # Fix build warnings
  prob_init_pres <- NULL; rm(prob_init_pres) # nolint, fixes warning: no visible binding for global variable

  # get the files names
  daisie_results_files <- list.files(results_dir)

  daisie_results_posterior_rep <- gsub(
    pattern = ".*cr_dd_[0-9]_",
    replacement = "",
    x = daisie_results_files
  )
  daisie_results_posterior_rep <- gsub(
    pattern = ".rds",
    replacement = "",
    x = daisie_results_posterior_rep
  )
  num_phylos <- max(as.numeric(daisie_results_posterior_rep))

  # results list
  results <- list()
  for (i in seq_len(num_phylos)) {

    # subset to the different initial parameter estimates
    posterior_rep <- daisie_results_files[grep(
      pattern = paste0("_", i, ".rds"),
      x = daisie_results_files)]

    # read in the oceanic data
    posterior_rep_results <- lapply(
      as.list(
        file.path(
          results_dir,
          posterior_rep
        )
      ),
      readRDS
    )

    # get the parameter set that has the best loglik
    best_posterior_rep <-DAISIEutils::choose_best_model(
      model_lik_res = posterior_rep_results
    )

    results[[i]] <- best_posterior_rep
  }

  # extract the values for each DAISIE parameter
  # if the parameter is not available for a replicate give NA
  lambda_c <- unlist(lapply(results, \(x) {
    if (is.null(x)) {
      NA_real_
    } else {
      x$lambda_c
    }
  }))

  mu <- unlist(lapply(results, \(x) {
    if (is.null(x)) {
      NA_real_
    } else {
      x$mu
    }
  }))

  K <- unlist(lapply(results, \(x) {
    if (is.null(x)) {
      NA_real_
    } else {
      x$K
    }
  }))

  gamma <- unlist(lapply(results, \(x) {
    if (is.null(x)) {
      NA_real_
    } else {
      x$gamma
    }
  }))

  lambda_a <- unlist(lapply(results, \(x) {
    if (is.null(x)) {
      NA_real_
    } else {
      x$lambda_a
    }
  }))

  loglik <- unlist(lapply(results, \(x) {
    if (is.null(x)) {
      NA_real_
    } else {
      x$loglik
    }
  }))

  bic <- unlist(lapply(results, \(x) {
    if (is.null(x)) {
      NA_real_
    } else {
      x$bic
    }
  }))

  prob_init_pres <- unlist(lapply(
    results, \(x) {
      if (is.null(x)) {
        NA_real_
      } else {
        x$prob_init_pres
      }
    }))

  # put posterior distribution of parameter estimates into tibble
  results_tbl <- tibble::tibble(
    phylo = 1:num_phylos,
    lambda_c = lambda_c,
    mu = mu,
    K = K,
    gamma = gamma,
    lambda_a = lambda_a,
    loglik = loglik,
    bic = bic,
    prob_init_pres = prob_init_pres
  )

  results_tbl <- tidyr::pivot_longer(
    data = results_tbl,
    cols = lambda_c:prob_init_pres,
    names_to = "params"
  )

  # return results_tbl
  results_tbl
}
