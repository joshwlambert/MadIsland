# script to collate all the DAISIE maximum likelihood parameter estimates for
# each taxonomic group across each posterior distribution of trees

# collate nonvolant mammal complete data for the nonoceanic model
nonvolant_mammal_complete_nonoceanic <- collate_daisie_output(
  results_dir = "nonvolant_mammal_daisie_data_list_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  nonvolant_mammal_complete_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "nonvolant_mammal_daisie_output",
    "nonvolant_mammal_complete_nonoceanic.rds"
  )
)

# collate mammal DNA data for the nonoceanic model
nonvolant_mammal_dna_nonoceanic <- collate_daisie_output(
  results_dir = "nonvolant_mammal_daisie_data_list_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  nonvolant_mammal_dna_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "nonvolant_mammal_daisie_output",
    "nonvolant_mammal_dna_nonoceanic.rds"
  )
)
