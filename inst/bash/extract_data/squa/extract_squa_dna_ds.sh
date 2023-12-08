#!/bin/bash
#SBATCH --time=0-01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=extract_squa_dna_ds
#SBATCH --output=logs/extract_squa_dna_ds.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

ml R
Rscript inst/scripts/extract_data/squa/extract_squa_dna_ds.R
