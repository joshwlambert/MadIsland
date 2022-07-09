# script to collate all the DAISIE maximum likelihood parameter estimates for
# each taxonomic group across each posterior distribution of trees

# collate amphibian complete data for the oceanic model
amphibian_complete_oceanic <- collate_daisie_output(
  results_dir = "amphibian_daisie_data_list_complete_ds_asr",
  oceanic_or_nonoceanic = "oceanic",
  num_phylos = 100
)

# save the collated data
saveRDS(
  amphibian_complete_oceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_complete_oceanic.rds"
  )
)

# collate amphibian complete data for the nonoceanic model
amphibian_complete_nonoceanic <- collate_daisie_output(
  results_dir = "amphibian_daisie_data_list_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 3
)

# save the collated data
saveRDS(
  amphibian_complete_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_complete_nonoceanic.rds"
  )
)

# collate amphibian DNA data for the oceanic model
amphibian_dna_oceanic <- collate_daisie_output(
  results_dir = "amphibian_daisie_data_list_dna_ds_asr",
  oceanic_or_nonoceanic = "oceanic",
  num_phylos = 3
)

# save the collated data
saveRDS(
  amphibian_dna_oceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_dna_oceanic.rds"
  )
)

# collate amphibian DNA data for the nonoceanic model
amphibian_dna_nonoceanic <- collate_daisie_output(
  results_dir = "amphibian_daisie_data_list_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 3
)

# save the collated data
saveRDS(
  amphibian_dna_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "amphibian_daisie_output",
    "amphibian_dna_nonoceanic.rds"
  )
)
