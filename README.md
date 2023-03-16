MadIsland

<!-- badges: start -->
[![R-CMD-check](https://github.com/joshwlambert/MadIsland/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/joshwlambert/MadIsland/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/joshwlambert/MadIsland/branch/main/graph/badge.svg)](https://app.codecov.io/gh/joshwlambert/MadIsland?branch=main)
<!-- badges: end -->

# Reproducibility

This section is a guide to reproducing the data and results in this package.

Running on the Peregrine High Performance Cluster Computer (HPCC):

Clone the DAISIEutils R package and the MadIsland R package in the home working
directory. Here the home working directory referes to home/p-number/. Then 
change directory into MadIsland (`cd MadIsland`). Run the install bash script
to ensure MadIsland is installed on the cluster (`sbatch inst/bash/install/install_MadIsland.sh`). 

Run the extraction scripts with MadIsland as the working directory due to the file paths for saving, for compatibility with running the scripts locally (e.g.
within Rstudio). The other option would be to have a platform identifier
(e.g. .Platform\$OS.type) to determine the file path as locally I use windows and
the Peregrine HPCC uses Linux (i.e. unix). However, this platform specific 
option prevents reproducibility for those running the scripts locally on a Mac 
or Linux machine (because .Platform$OS.type == "unix" in those cases). The logs
folder is already present at this point as it is made in the install of MadIsland, but good to check that the logs folder is in MadIsland. 

Run each of the extraction scripts to produce the extracted data:

  * `sbatch inst/bash/extract_data/amphibians/extract_amphibians_complete_ds_asr.sh`
  * `sbatch inst/bash/extract_data/amphibians/extract_amphibians_dna_ds_asr.sh`
  * `sbatch inst/bash/extract_data/birds/extract_birds_complete_ds_asr.sh`
  * `sbatch inst/bash/extract_data/birds/extract_birds_dna_ds_asr.sh`
  * `sbatch inst/bash/extract_data/nonvolant_mammals/extract_nonvolant_mammals_complete_ds_asr.sh`
  * `sbatch inst/bash/extract_data/nonvolant_mammals/extract_nonvolant_mammals_dna_ds_asr.sh`
  * `sbatch inst/bash/extract_data/volant_mammals/extract_volant_mammals_complete_ds_asr.sh`
  * `sbatch inst/bash/extract_data/volant_mammals/extract_volant_mammals_dna_ds_asr.sh`
  * `sbatch inst/bash/extract_data/squamates/extract_squamates_complete_ds_asr.sh`
  * `sbatch inst/bash/extract_data/squamates/extract_squamates_dna_ds_asr.sh`
  
Before running the analyses, make sure a logs folder is in the home directory. 
If this is not present create a logs folder.

Now that the island community data has been extracted and can be used for 
fitting the DAISIE inference models there is one more preparation step. The
DAISIEutils package loads data using the `data()` function and thus it cannot
be loaed from within the inst/ folder where the extracted data is currently 
stored. Therefore, the data-raw scripts need to be executed to move the data
sets we are fitting DAISIE to across to data. All data-raw scripts read the 
extracted data from inst/extdata/extracted_data/... and save it as data to be 
read by `data()`.

Run the analysis scripts the home working directory on the Peregrine HPCC. 
This is because MadIsland interacts with the DAISIEutils package to run the 
DAISIE maximum likelihood models.

Run each of the analysis scripts to produce the DAISIE model output (parameter
estimates and model likelihood and Bayesian Information Criterion):

  * `sbatch MadIsland/inst/bash/analyse_data/analyse_amphibians/submit_amphibian_complete_nonoceanic_cr_dd.sh`
  * `sbatch MadIsland/inst/bash/analyse_data/analyse_amphibians/submit_amphibian_dna_nonoceanic_cr_dd.sh`
  * `sbatch MadIsland/inst/bash/analyse_data/analyse_birds/submit_bird_complete_nonoceanic_cr_dd.sh`
  * `sbatch MadIsland/inst/bash/analyse_data/analyse_birds/submit_bird_dna_nonoceanic_cr_dd.sh`
  * `sbatch MadIsland/inst/bash/analyse_data/analyse_nonvolant_mammals/submit_nonvolant_mammal_complete_nonoceanic_cr_dd.sh`
  * `sbatch MadIsland/inst/bash/analyse_data/analyse_nonvolant_mammals/submit_nonvolant_mammal_dna_nonoceanic_cr_dd.sh`
  * `sbatch MadIsland/inst/bash/analyse_data/analyse_volant_mammals/submit_volant_mammal_complete_nonoceanic_cr_dd.sh`
  * `sbatch MadIsland/inst/bash/analyse_data/analyse_volant_mammals/submit_volant_mammal_dna_nonoceanic_cr_dd.sh`
  * `sbatch MadIsland/inst/bash/analyse_data/analyse_squamates/submit_squamate_complete_nonoceanic_cr_dd.sh`
  * `sbatch MadIsland/inst/bash/analyse_data/analyse_squamates/submit_squamate_dna_nonoceanic_cr_dd.sh`
  


