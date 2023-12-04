#!/bin/bash
#SBATCH --time=0-01:00:00
#SBATCH --partition=gelifes
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=install_MadIsland
#SBATCH --output=install_MadIsland.log
#SBATCH --mem=5GB

mkdir -p logs
ml R
Rscript -e "install.packages(c('renv', 'devtools'))"
Rscript -e "renv::restore(prompt = FALSE)"
Rscript -e "devtools::install()"
