library(dplyr)
library(remakeGenerator)

# Create folders: 
ff <- c('datasets', 'analyses', 'msg', 'output')
sapply(ff, dir.create, showWarnings=FALSE)

# Instructions for dataset simulation
datasets = commands(
  small = setup_sim(5000, 1000, 4, 20000, 1000),
  large = setup_sim(50000, 5000, 8, 20000, 1000)
  ) %>%
  expand(values = c("rep1","rep2","rep3","rep4"))

# Instructions for run analysis
analyses = analyses(
  commands = commands(
    mc_sb = mcmc_sb(..dataset..)
    ), 
  datasets = datasets)

# save all instructions
save(datasets, analyses, file='targets.Rdata')
