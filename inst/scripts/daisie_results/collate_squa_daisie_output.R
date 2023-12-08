# script to collate all the DAISIE maximum likelihood parameter estimates for
# each taxonomic group across each posterior distribution of trees

# collate squamate complete data for the nonoceanic model
squamate_complete_nonoceanic <- collate_daisie_output(
  results_dir = "squamate_daisie_data_list_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  squamate_complete_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_complete_nonoceanic.rds"
  )
)

# collate squamate DNA data for the nonoceanic model
squamate_dna_nonoceanic <- collate_daisie_output(
  results_dir = "squamate_daisie_data_list_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  squamate_dna_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_dna_nonoceanic.rds"
  )
)
