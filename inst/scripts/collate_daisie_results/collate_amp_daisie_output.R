# script to collate all the DAISIE maximum likelihood parameter estimates for
# each taxonomic group across each posterior distribution of trees

# collate amphibian complete data for the nonoceanic model
amp_complete_nonoceanic <- collate_daisie_output(
  results_dir = "amp_dll_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  amp_complete_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "amp_daisie_output",
    "amp_complete_nonoceanic.rds"
  )
)

# collate amphibian DNA data for the nonoceanic model
amp_dna_nonoceanic <- collate_daisie_output(
  results_dir = "amp_dll_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  amp_dna_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "amp_daisie_output",
    "amp_dna_nonoceanic.rds"
  )
)
