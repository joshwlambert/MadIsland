# script to collate all the DAISIE maximum likelihood parameter estimates for
# each taxonomic group across each posterior distribution of trees

# collate mammal complete data for the nonoceanic model
volant_mammal_complete_nonoceanic <- collate_daisie_output(
  results_dir = "volant_mammal_daisie_data_list_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  volant_mammal_complete_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "volant_mammal_daisie_output",
    "volant_mammal_complete_nonoceanic.rds"
  )
)

# collate mammal DNA data for the nonoceanic model
volant_mammal_dna_nonoceanic <- collate_daisie_output(
  results_dir = "volant_mammal_daisie_data_list_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  volant_mammal_dna_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "volant_mammal_daisie_output",
    "volant_mammal_dna_nonoceanic.rds"
  )
)
