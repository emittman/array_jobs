library(dplyr)
library(remakeGenerator)

# Create folders: 
ff <- c('datasets', 'analyses', 'msg', 'output')
sapply(ff, dir.create, showWarnings=FALSE)

# Instructions for dataset simulation
#syntax GVK refers to G in {5000,40000}, K in {2000, 4000, 8000}, V in {2,4,6}
datasets = commands(
 sss=setup_sim(G=5000, K=2000, V=2, n_iter=30000, warmup=1),
 ssm=setup_sim(5000, 2000, 4, n_iter=30000, warmup=1),
 ssl=setup_sim(5000, 2000, 6, n_iter=40000, warmup=1),
 sms=setup_sim(5000, 4000, 2, n_iter=30000, warmup=1),
 smm=setup_sim(5000, 4000, 4, n_iter=30000, warmup=1),
 sml=setup_sim(5000, 4000, 6, n_iter=40000, warmup=1),
 sls=setup_sim(5000, 8000, 2, n_iter=30000, warmup=1),
 slm=setup_sim(5000, 8000, 4, n_iter=30000, warmup=1),
 sll=setup_sim(5000, 8000, 6, n_iter=50000, warmup=1),
 lss=setup_sim(40000, 2000, 2, n_iter=30000, warmup=1),
 lsm=setup_sim(40000, 2000, 4, n_iter=30000, warmup=1),
 lsl=setup_sim(40000, 2000, 6, n_iter=40000, warmup=1),
 lms=setup_sim(40000, 4000, 2, n_iter=30000, warmup=1),
 lmm=setup_sim(40000, 4000, 4, n_iter=30000, warmup=1),
 lml=setup_sim(40000, 4000, 6, n_iter=40000, warmup=1),
 lls=setup_sim(40000, 8000, 2, n_iter=30000, warmup=1),
 llm=setup_sim(40000, 8000, 4, n_iter=30000, warmup=1),
 lll=setup_sim(40000, 8000, 6, n_iter=50000, warmup=1))

# Instructions for run analysis
analyses = analyses(
  commands = commands(
    mc_sb = mcmc_sb(..dataset..)
    ), 
  datasets = datasets)

# save all instructions
save(datasets, analyses, file='targets.Rdata')
