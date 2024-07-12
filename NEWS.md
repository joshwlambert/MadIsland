# MadIsland 0.3.0

The new minor version release of the MadIsland R package contains various minor updates for Lambert, Etienne and Valente (_in progress_).

Changes include:

* A new `create_daisie_transition_matrix()` function to easily create transition matrices that are parameterised for ancestral state reconstruction similar to the DAISIE inference model (unit tests also added).
* Update to `collate_daisie_output()` to handle DAISIE inference model outputs from the continental and oceanic model (as bats now fit the oceanic DAISIE model).
* `min_median_rd_params()` now checks to prevent division by zero.
* The extraction Malagasy island communities have been updated (`inst/extdata` and `data/`).
* The bash scripts for the volant mammals have been updated to call the constant-rate (oceanic) DAISIE model (`inst/bash`), the island age in the extraction scripts (`inst/scripts/extract_data/`) have also been updated to use 75 instead of 88 for volant mammals.
* Plots for the manuscript have been updated.
* The `reproducibility.Rmd` vignette has been updated with a Collating DAISIE results section.
* The `renv.lock` file is updated.

# MadIsland 0.2.0

Updates to the MadIsland R package accompanying a new version of the Lambert, Etienne and Valente manuscript (work in progress).

Main changes include:

* Update to the optimisation algorithm used in the DAISIE analysis from `subplex` to `simplex`.
* The collated data is updated as a result of the changes in model setup in the DAISIE analysis.
* Plots have been updated:
  - Figures now have been post-processed to include silhouettes from [phylopic](https://www.phylopic.org/). These silhouettes are in the public domain and included with the package (`inst/plots/phylopic/`).
  - The carrying capacity plots change from using density (`ggplot2::geom_density()`) to using histograms (`ggplot2::geom_histogram()`). This is due to more taxonomic groups having carrying capacities less than 1,000 and so are included in the plot, owing to the change in optimisation algorithm used in the DAISIE analysis.
  - Plotting scripts that require post-processing now also save SVG (`.svg`) version of the plots for easier editing of vector graphics.
* The `reproducibility.Rmd` vignette gains a new short section on plotting. 

# MadIsland 0.1.0

* First release of MadIsland, an R package for conducting and reproducing the Madagascar vertebrate island biogeography study of Lambert, Etienne and Valente.
* The R package contains all of the data (and some intemediate data) that is used in the analysis, as well as functions and scripts to run the analysis and create the plots.
* Scripts include both R scripts and bash scripts to run analyses on the Groningen HPC.
