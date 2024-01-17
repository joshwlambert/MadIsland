#!/bin/bash
#SBATCH --time=1-23:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=extract_bird_complete
#SBATCH --output=logs/extract_bird_complete.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

ml R
Rscript inst/scripts/extract_data/bird/extract_bird_complete.R
