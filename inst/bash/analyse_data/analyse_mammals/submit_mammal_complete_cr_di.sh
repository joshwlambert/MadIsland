#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=mammal_mls
#SBATCH --output=/logs/submit_mammal_mls_cr_di_%a.log
#SBATCH --mem=5GB
#SBATCH --partition=regular
#SBATCH --array=1-3

sbatch DAISIEutils/bash/submit_run_daisie_ml.sh mammal_daisie_data_list_complete_ds_asr \
  cr_di \
  MadIsland \
  0 \
  NULL \
  lsodes \
  subplex \
  TRUE \
  ${SLURM_ARRAY_TASK_ID}
