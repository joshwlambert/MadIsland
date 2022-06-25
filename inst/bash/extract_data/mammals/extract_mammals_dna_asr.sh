#!/bin/bash
#SBATCH --time=70:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=extract_mammals_dna_asr
#SBATCH --output=logs/extract_mammals_dna_asr.log
#SBATCH --mem=5GB
#SBATCH --partition=regular

ml R
Rscript inst/scripts/extract_data/mammals/extract_mammals_dna_asr.R
