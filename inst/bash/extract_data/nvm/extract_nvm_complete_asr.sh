#!/bin/bash
#SBATCH --time=1-23:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=extract_nvm_complete_asr
#SBATCH --output=logs/extract_nvm_complete_asr.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

ml R
Rscript inst/scripts/extract_data/nvm/extract_nvm_complete_asr.R
