#!/bin/bash
#SBATCH --time=70:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=extract_amphibians_complete_asr
#SBATCH --output=logs/extract_amphibians_complete_asr.log
#SBATCH --mem=5GB
#SBATCH --partition=regular

ml R
Rscript MadIsland/inst/scripts/extract_data/amphibians/extract_amphibians_complete_asr.R
