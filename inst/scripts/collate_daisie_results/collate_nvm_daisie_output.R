# script to collate all the DAISIE maximum likelihood parameter estimates for
# each taxonomic group across each posterior distribution of trees

# collate nonvolant mammal complete data for the nonoceanic model
nvm_complete_nonoceanic <- collate_daisie_output(
  results_dir = "nvm_ddl_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  nvm_complete_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "nvm_daisie_output",
    "nvm_complete_nonoceanic.rds"
  )
)

# collate mammal DNA data for the nonoceanic model
nvm_dna_nonoceanic <- collate_daisie_output(
  results_dir = "nvm_ddl_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  nvm_dna_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "nvm_daisie_output",
    "nvm_dna_nonoceanic.rds"
  )
)
