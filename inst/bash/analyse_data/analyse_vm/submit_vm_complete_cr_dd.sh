#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=volant_mammal_complete_mls
#SBATCH --output=logs/submit_volant_mammal_complete_mls_cr_dd_%a.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes
#SBATCH --array=1-5

sbatch DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  volant_mammal_daisie_data_list_complete_ds_asr \
  cr_dd \
  MadIsland \
  0 \
  NULL \
  lsodes \
  subplex \
  TRUE \
  ${SLURM_ARRAY_TASK_ID} \
  500
