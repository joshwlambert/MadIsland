# script to collate all the DAISIE maximum likelihood parameter estimates for
# each taxonomic group across each posterior distribution of trees

# collate squamate complete data for the nonoceanic model
squa_complete_nonoceanic <- collate_daisie_output(
  results_dir = "squa_ddl_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 100
)

# save the collated data
saveRDS(
  squa_complete_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "squa_daisie_output",
    "squa_complete_nonoceanic.rds"
  )
)

# collate squamate DNA data for the nonoceanic model
squa_dna_nonoceanic <- collate_daisie_output(
  results_dir = "squa_ddl_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 100
)

# save the collated data
saveRDS(
  squa_dna_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "squa_daisie_output",
    "squa_dna_nonoceanic.rds"
  )
)
