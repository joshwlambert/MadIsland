#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=mammal_mls
#SBATCH --output=logs/mammal_mls.log
#SBATCH --mem=5GB
#SBATCH --partition=regular
#SBATCH --array=1-3

ml R
Rscript /home/p287218/MadIsland/inst/scripts/subset_data/subset_data.R ${SLURM_ARRAY_TASK_ID}
