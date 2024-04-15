#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=squa_complete_mls
#SBATCH --output=logs/submit_squa_complete_mls_cr_dd_%a.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes
#SBATCH --array=1-100

sbatch DAISIEutils/bash/submit_run_daisie_ml.sh \
  squa_ddl_complete_ds_asr \
  cr_dd \
  MadIsland \
  0 \
  NULL \
  lsodes \
  simplex \
  TRUE \
  ${SLURM_ARRAY_TASK_ID} \
  500
