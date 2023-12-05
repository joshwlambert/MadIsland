# Amphibians

amphibians <- read_checklist(file_name = "amp_checklist.csv")
head(amphibians)
checklist_stats(amphibians)

# Birds

birds <- read_checklist(file_name = "bird_checklist.csv")
head(birds)
checklist_stats(birds)

# Non-volant Mammals

nonvolant_mammals <- read_checklist(file_name = "nvm_checklist.csv")
head(nonvolant_mammals)
checklist_stats(nonvolant_mammals)

# Volant Mammals

volant_mammals <- read_checklist(file_name = "vm_checklist.csv")
head(volant_mammals)
checklist_stats(volant_mammals)

# Squamates

squamates <- read_checklist(file_name = "squa_checklist.csv")
head(squamates)
checklist_stats(squamates)
