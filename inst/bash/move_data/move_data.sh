#!/bin/bash
#SBATCH --time=0-01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=move_data
#SBATCH --output=logs/move_data.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

ml R
Rscript data-raw/amp_ddl_complete_ds_asr.R
Rscript data-raw/amp_ddl_dna_ds_asr.R
Rscript data-raw/bird_ddl_complete_ds_asr.R
Rscript data-raw/bird_ddl_dna_ds_asr.R
Rscript data-raw/nvm_ddl_complete_ds_asr.R
Rscript data-raw/nvm_ddl_dna_ds_asr.R
Rscript data-raw/squa_ddl_complete_ds_asr.R
Rscript data-raw/squa_ddl_dna_ds_asr.R
Rscript data-raw/vm_ddl_complete_ds_asr.R
Rscript data-raw/vm_ddl_dna_ds_asr.R
echo "Finished saving extracted data in data dir"
