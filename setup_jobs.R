library(dplyr)
library(remakeGenerator)

# Create folders: 
ff <- c('datasets', 'analyses', 'msg', 'output')
sapply(ff, dir.create, showWarnings=FALSE)

# Instructions for dataset simulation
datasets = commands(
  small = setup_sim(5000, 1000, 4, 20000, 10000),
  large = setup_sim(50000, 6000, 8, 20000, 30000)
  ) %>%
  expand(values = c("rep1","rep2","rep3"))

# Instructions for run analysis
analyses = analyses(
  commands = commands(
    mc_sb = mcmc_sb(..dataset..)
    ), 
  datasets = datasets)

# save all instructions
save(datasets, analyses, file='targets.Rdata')
