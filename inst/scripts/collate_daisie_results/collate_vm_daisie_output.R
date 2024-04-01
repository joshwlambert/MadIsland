# script to collate all the DAISIE maximum likelihood parameter estimates for
# each taxonomic group across each posterior distribution of trees

# collate mammal complete data for the nonoceanic model
vm_complete_nonoceanic <- collate_daisie_output(
  results_dir = "vm_ddl_complete_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  vm_complete_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "vm_daisie_output",
    "vm_complete_nonoceanic.rds"
  )
)

# collate mammal DNA data for the nonoceanic model
vm_dna_nonoceanic <- collate_daisie_output(
  results_dir = "vm_ddl_dna_ds_asr",
  oceanic_or_nonoceanic = "nonoceanic",
  num_phylos = 20
)

# save the collated data
saveRDS(
  vm_dna_nonoceanic,
  file.path(
    "inst",
    "extdata",
    "collated_daisie_output",
    "vm_daisie_output",
    "vm_dna_nonoceanic.rds"
  )
)
