library(dplyr)
library(remakeGenerator)

# Create folders: 
ff <- c('datasets', 'analyses', 'msg', 'output')
sapply(ff, dir.create, showWarnings=FALSE)

# Instructions for dataset simulation
datasets = commands(
  small = setup_sim(5000, 1000, 4),
  large = setup_sim(50000, 5000, 8)
  ) %>%
  expand(values = c("rep1","rep2","rep3","rep4"))

# Instructions for run analysis
analyses = analyses(
  commands = commands(
    mc_sb = mcmc_sb(..dataset.., 10, 10)
    ), 
  datasets = datasets)

# save all instructions
save(datasets, analyses, file='targets.Rdata')
