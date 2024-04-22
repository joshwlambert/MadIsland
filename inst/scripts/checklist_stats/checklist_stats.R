# Amphibians

amphibians <- read_checklist(file_name = "amp_checklist.csv")
head(amphibians)
amp <- checklist_stats(amphibians)

# Birds

birds <- read_checklist(file_name = "bird_checklist.csv")
head(birds)
birds <- checklist_stats(birds)

# Non-volant Mammals

nonvolant_mammals <- read_checklist(file_name = "nvm_checklist.csv")
head(nonvolant_mammals)
nvm <- checklist_stats(nonvolant_mammals)

# Volant Mammals

volant_mammals <- read_checklist(file_name = "vm_checklist.csv")
head(volant_mammals)
vm <- checklist_stats(volant_mammals)

# Squamates

squamates <- read_checklist(file_name = "squa_checklist.csv")
head(squamates)
squamates <- checklist_stats(squamates)

data.frame(
  amp = unlist(amp),
  bird = unlist(bird),
  nvm = unlist(nvm),
  squa = unlist(squa),
  vm = unlist(vm)
)
