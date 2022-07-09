# script to plot the parameter estimates of the amphibian data

# get the files names
files <- list.files(
  system.file(
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    package = "MadIsland",
    mustWork = TRUE
  )
)

readRDS()




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
        "inst",
        "extdata",
        "raw_daisie_output",
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

# put posterior distribution of parameter estimates into tibble
results_tbl <- tibble::tibble(
  phylo = 1:num_phylos,
  lambda_c = vapply(results, "[[", "lambda_c", FUN.VALUE = numeric(1)),
  mu = vapply(results, "[[", "mu", FUN.VALUE = numeric(1)),
  K = vapply(results, "[[", "K", FUN.VALUE = numeric(1)),
  gamma = vapply(results, "[[", "gamma", FUN.VALUE = numeric(1)),
  lambda_a = vapply(results, "[[", "lambda_a", FUN.VALUE = numeric(1)),
  loglik = vapply(results, "[[", "loglik", FUN.VALUE = numeric(1)),
  bic = vapply(results, "[[", "bic", FUN.VALUE = numeric(1)),
  prob_init_pres = rep(NA_real_, num_phylos)
)

if (oceanic_or_nonoceanic == "nonoceanic") {
  results_tbl$prob_init_pres <- vapply(
    results,
    "[[",
    "prob_init_pres",
    FUN.VALUE = numeric(1)
  )
}

# return results_tbl
results_tbl
