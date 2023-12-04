#!/bin/bash
#SBATCH --time=0-01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=move_data
#SBATCH --output=logs/move_data.log
#SBATCH --mem=5GB
#SBATCH --partition=gelifes

ml R
Rscript data-raw/amphibian_daisie_data_list_complete_ds_asr.R
Rscript data-raw/amphibian_daisie_data_list_dna_ds_asr.R
Rscript data-raw/bird_daisie_data_list_complete_ds_asr.R
Rscript data-raw/bird_daisie_data_list_dna_ds_asr.R
Rscript data-raw/nonvolant_mammal_daisie_data_list_complete_ds_asr.R
Rscript data-raw/nonvolant_mammal_daisie_data_list_dna_ds_asr.R
Rscript data-raw/squamate_daisie_data_list_complete_ds_asr.R
Rscript data-raw/squamate_daisie_data_list_dna_ds_asr.R
Rscript data-raw/volant_mammal_daisie_data_list_complete_ds_asr.R
Rscript data-raw/volant_mammal_daisie_data_list_dna_ds_asr.R
echo "Finished saving extracted data in data dir"
