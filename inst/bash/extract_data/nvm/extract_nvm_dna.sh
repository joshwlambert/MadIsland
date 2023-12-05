#!/bin/bash
#SBATCH --time=0-01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=extract_nonvolant_mammals_dna
#SBATCH --output=logs/extract_nonvolant_mammals_dna.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

ml R
Rscript inst/scripts/extract_data/nonvolant_mammals/extract_nonvolant_mammals_dna.R
