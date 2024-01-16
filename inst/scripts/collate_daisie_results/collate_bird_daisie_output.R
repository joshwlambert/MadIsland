# script to collate all the DAISIE maximum likelihood parameter estimates for
# each taxonomic group across each posterior distribution of trees

# collate bird complete data for the nonoceanic model
bird_complete_nonoceanic <- collate_daisie_output(
  results_dir = "bird_ddl_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  bird_complete_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "bird_daisie_output",
    "bird_complete_nonoceanic.rds"
  )
)

# collate bird DNA data for the nonoceanic model
bird_dna_nonoceanic <- collate_daisie_output(
  results_dir = "bird_ddl_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  bird_dna_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "bird_daisie_output",
    "bird_dna_nonoceanic.rds"
  )
)
