# collate mammal complete data for the oceanic model
mammal_complete_oceanic <- collate_daisie_output(
  results_dir = "mammal_daisie_data_list_complete_ds_asr",
  oceanic_or_nonoceanic = "oceanic",
  num_phylos = 3
)

# save the collated data
saveRDS(
  mammal_complete_oceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "mammal_daisie_output",
    "mammal_complete_oceanic.rds"
  )
)

# collate mammal complete data for the nonoceanic model
mammal_complete_nonoceanic <- collate_daisie_output(
  results_dir = "mammal_daisie_data_list_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 3
)

# save the collated data
saveRDS(
  mammal_complete_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "mammal_daisie_output",
    "mammal_complete_nonoceanic.rds"
  )
)

# collate mammal DNA data for the oceanic model
mammal_dna_oceanic <- collate_daisie_output(
  results_dir = "mammal_daisie_data_list_dna_ds_asr",
  oceanic_or_nonoceanic = "oceanic",
  num_phylos = 3
)

# save the collated data
saveRDS(
  mammal_dna_oceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "mammal_daisie_output",
    "mammal_dna_oceanic.rds"
  )
)

# collate mammal DNA data for the nonoceanic model
mammal_dna_nonoceanic <- collate_daisie_output(
  results_dir = "mammal_daisie_data_list_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 3
)

# save the collated data
saveRDS(
  mammal_dna_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "mammal_daisie_output",
    "mammal_dna_nonoceanic.rds"
  )
)
