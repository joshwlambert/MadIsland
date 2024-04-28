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
