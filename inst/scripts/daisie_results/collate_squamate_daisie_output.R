# collate squamate complete data for the oceanic model
squamate_complete_oceanic <- collate_daisie_output(
  results_dir = "squamate_daisie_data_list_complete_ds_asr",
  oceanic_or_nonoceanic = "oceanic",
  num_phylos = 3
)

# save the collated data
saveRDS(
  squamate_complete_oceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_complete_oceanic.rds"
  )
)

# collate squamate complete data for the nonoceanic model
squamate_complete_nonoceanic <- collate_daisie_output(
  results_dir = "squamate_daisie_data_list_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 3
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

# collate squamate DNA data for the oceanic model
squamate_dna_oceanic <- collate_daisie_output(
  results_dir = "squamate_daisie_data_list_dna_ds_asr",
  oceanic_or_nonoceanic = "oceanic",
  num_phylos = 3
)

# save the collated data
saveRDS(
  squamate_dna_oceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "squamate_daisie_output",
    "squamate_dna_oceanic.rds"
  )
)

# collate squamate DNA data for the nonoceanic model
squamate_dna_nonoceanic <- collate_daisie_output(
  results_dir = "squamate_daisie_data_list_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 3
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
