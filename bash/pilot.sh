#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=mammal_mls
#SBATCH --output=MadIsland/logs/mammal_mls_%a.log
#SBATCH --mem=5GB
#SBATCH --partition=regular
#SBATCH --array=1-3

ml R
Rscript /home/p287218/MadIsland/inst/scripts/subset_data/subset_data.R ${SLURM_ARRAY_TASK_ID}

mammal_data="mammal_data_"$SLURM_ARRAY_TASK_ID

sbatch --job-name=mammals_mls DAISIEutils/bash/submit_run_daisie_ml.sh mammal_data_1 cr_di MadIsland 0 NULL lsodes subplex TRUE
