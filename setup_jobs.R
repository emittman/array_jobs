library(dplyr)
library(remakeGenerator)

# Create folders: 
ff <- c('datasets', 'analyses', 'msg', 'output')
sapply(ff, dir.create, showWarnings=FALSE)

# Instructions for dataset simulation
datasets = commands(
#  verysmall = setup_sim(1000, 1000, 2, 20000, 10000),
#  small = setup_sim(5000, 5000, 3, 20000, 10000),
#  medium = setup_sim(10000, 5000, 4, 20000, 10000),
  mediumv5 = setup_sim(10000, 5000, 5, 20000, 10000),
  largek7000 = setup_sim(40000, 7000, 6, 20000, 20000),
  largek8000 = setup_sim(40000, 8000, 6, 20000, 20000)) %>%
  expand(values = c("rep1","rep2"))

# Instructions for run analysis
analyses = analyses(
  commands = commands(
    mc_sb = mcmc_sb(..dataset..)
    ), 
  datasets = datasets)

# save all instructions
save(datasets, analyses, file='targets.Rdata')
