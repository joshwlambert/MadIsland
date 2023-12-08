data("volant_mammal_daisie_data_list_complete_ds_asr")
plot_stt(
  daisie_data_list = volant_mammal_daisie_data_list_complete_ds_asr,
  log_num_species = TRUE,
  median_res = 0.1
)

data("volant_mammal_daisie_data_list_dna_ds_asr.rda")
plot_stt(
  daisie_data_list = volant_mammal_daisie_data_list_dna_ds_asr,
  log_num_species = TRUE,
  median_res = 0.1
)
