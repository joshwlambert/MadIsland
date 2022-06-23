#!/bin/bash
#SBATCH --time=1-23:00:00
#SBATCH --partition=regular
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=install_MadIsland
#SBATCH --output=install_MadIsland.log
#SBATCH --mem=5GB

mkdir -p logs
ml R
Rscript -e "remotes::install_github('joshwlambert/MadIsland')"
Rscript -e 'remotes::install_github("tece-lab/DAISIEutils@extdata")'
