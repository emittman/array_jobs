library(dplyr)
library(remakeGenerator)

# Create folders: 
ff <- c('datasets', 'analyses', 'msg', 'output')
sapply(ff, dir.create, showWarnings=FALSE)

# Instructions for dataset simulation
#syntax GVK refers to G in {5000,40000}, K in {2000, 4000, 8000}, V in {2,4,6}
datasets = commands(
 sss=setup_sim(G=2^12, K=2^10, V=2, n_iter=30000, warmup=5000, init.iter=50),
 ssm=setup_sim(2^12, 2^10, 4, n_iter=30000, warmup=5000, init.iter=50),
 ssl=setup_sim(2^12, 2^10, 6, n_iter=30000, warmup=5000, init.iter=50),
 sms=setup_sim(2^12, 2^11, 2, n_iter=30000, warmup=5000, init.iter=50),
 smm=setup_sim(2^12, 2^11, 4, n_iter=30000, warmup=5000, init.iter=50),
 sml=setup_sim(2^12, 2^11, 6, n_iter=30000, warmup=5000, init.iter=50),
 sls=setup_sim(2^12, 2^12, 2, n_iter=30000, warmup=5000, init.iter=50),
 slm=setup_sim(2^12, 2^12, 4, n_iter=30000, warmup=5000, init.iter=50),
 sll=setup_sim(2^12, 2^12, 6, n_iter=30000, warmup=5000, init.iter=50),
 lss=setup_sim(2^15, 2^10, 2, n_iter=30000, warmup=5000, init.iter=50),
 lsm=setup_sim(2^15, 2^10, 4, n_iter=30000, warmup=5000, init.iter=50),
 lsl=setup_sim(2^15, 2^10, 6, n_iter=30000, warmup=5000, init.iter=50),
 lms=setup_sim(2^15, 2^11, 2, n_iter=30000, warmup=5000, init.iter=50),
 lmm=setup_sim(2^15, 2^11, 4, n_iter=30000, warmup=5000, init.iter=50),
 lml=setup_sim(2^15, 2^11, 6, n_iter=30000, warmup=5000, init.iter=50),
 lls=setup_sim(2^15, 2^12, 2, n_iter=30000, warmup=5000, init.iter=50),
 llm=setup_sim(2^15, 2^12, 4, n_iter=30000, warmup=5000, init.iter=50),
 lll=setup_sim(2^15, 2^12, 6, n_iter=30000, warmup=5000, init.iter=50))

# Instructions for run analysis
analyses = analyses(
  commands = commands(
    mcmc = mcmc_sb(..dataset..),
    mcmc2 = mcmc_sd(..dataset..)
    ), 
  datasets = datasets)

# save all instructions
save(datasets, analyses, file='targets.Rdata')
