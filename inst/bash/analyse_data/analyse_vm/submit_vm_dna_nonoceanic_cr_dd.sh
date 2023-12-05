#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=vm_dna_mls
#SBATCH --output=logs/submit_vm_dna_mls_nonoceanic_cr_dd_%a.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes
#SBATCH --array=1-5

sbatch DAISIEutils/bash/submit_run_daisie_ml_long.sh \
  vm_ddl_dna_ds_asr \
  nonoceanic_cr_dd \
  MadIsland \
  0 \
  NULL \
  lsodes \
  subplex \
  TRUE \
  ${SLURM_ARRAY_TASK_ID} \
  500
