#!/bin/bash
#SBATCH --time=1-23:00:00
#SBATCH --partition=gelifes
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=run_amphibian_analysis
#SBATCH --output=/data/p287218/MadIsland/logs/run_amphibian_analysis_%a.log
#SBATCH --array=1-10
#SBATCH --mem=5GB

model=$1
dataset=${SLURM_ARRAY_TASK_ID}

ml R
Rscript /data/p287218/MadIsland/scripts/analyse_amphibians_parallel.R ${model} ${dataset}
