#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=mammal_mls
#SBATCH --output=MadIsland/logs/mammal_mls_%a.log
#SBATCH --mem=5GB
#SBATCH --partition=regular
#SBATCH --array=1-3

sbatch --job-name=mammals_mls DAISIEutils/bash/submit_run_daisie_ml.sh mammal_data_1 cr_di MadIsland 0 NULL lsodes subplex TRUE ${SLURM_ARRAY_TASK_ID}
