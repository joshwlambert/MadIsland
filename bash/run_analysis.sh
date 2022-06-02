#!/bin/bash
#SBATCH --time=1-23:00:00
#SBATCH --partition=gelifes
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=run_analysis
#SBATCH --output=/data/p287218/MadIsland/logs/run_analysis.log
#SBATCH --mem=5GB

ml R
Rscript /data/p287218/DAISIEprepExtra/scripts/performance.R
