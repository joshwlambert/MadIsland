# Amphibians

amphibians <- read_checklist(file_name = "amphibian_checklist.csv")
head(amphibians)
checklist_stats(amphibians)

# Birds

birds <- read_checklist(file_name = "bird_checklist.csv")
head(birds)
checklist_stats(birds)

# Non-volant Mammals

nonvolant_mammals <- read_checklist(file_name = "nonvolant_mammal_checklist.csv")
head(nonvolant_mammals)
checklist_stats(nonvolant_mammals)

# Volant Mammals

volant_mammals <- read_checklist(file_name = "volant_mammal_checklist.csv")
head(volant_mammals)
checklist_stats(volant_mammals)

# Squamates

squamates <- read_checklist(file_name = "squamate_checklist.csv")
head(squamates)
checklist_stats(squamates)
