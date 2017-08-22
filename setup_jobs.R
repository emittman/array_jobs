library(dplyr)
library(remakeGenerator)

# Create folders: 
ff <- c('datasets', 'analyses', 'msg', 'output')
sapply(ff, dir.create, showWarnings=FALSE)

# Instructions for dataset simulation
#syntax GVK refers to G in 2^{12,15}, K in {2000, 4000, 8000}, V in {2,4,6}
#edit: new letters for gene size: m = 2^13, h = 2^14
datasets = commands(
 mss=setup_sim(G=2^13, K=2^10, V=2, n_iter=50000, warmup=5000, init.iter=500),
 msm=setup_sim(2^13, 2^10, 4, n_iter=50000, warmup=5000, init.iter=500),
 msl=setup_sim(2^13, 2^10, 6, n_iter=50000, warmup=5000, init.iter=500),
 mms=setup_sim(2^13, 2^11, 2, n_iter=50000, warmup=5000, init.iter=500),
 mmm=setup_sim(2^13, 2^11, 4, n_iter=50000, warmup=5000, init.iter=500),
 mml=setup_sim(2^13, 2^11, 6, n_iter=50000, warmup=5000, init.iter=500),
 mls=setup_sim(2^13, 2^12, 2, n_iter=50000, warmup=5000, init.iter=500),
 mlm=setup_sim(2^13, 2^12, 4, n_iter=50000, warmup=5000, init.iter=500),
 mll=setup_sim(2^13, 2^12, 6, n_iter=50000, warmup=5000, init.iter=500),
 hss=setup_sim(2^14, 2^10, 2, n_iter=50000, warmup=5000, init.iter=500),
 hsm=setup_sim(2^14, 2^10, 4, n_iter=50000, warmup=5000, init.iter=500),
 hsl=setup_sim(2^14, 2^10, 6, n_iter=50000, warmup=5000, init.iter=500),
 hms=setup_sim(2^14, 2^11, 2, n_iter=50000, warmup=5000, init.iter=500),
 hmm=setup_sim(2^14, 2^11, 4, n_iter=50000, warmup=5000, init.iter=500),
 hml=setup_sim(2^14, 2^11, 6, n_iter=50000, warmup=5000, init.iter=500),
 hls=setup_sim(2^14, 2^12, 2, n_iter=50000, warmup=5000, init.iter=500),
 hlm=setup_sim(2^14, 2^12, 4, n_iter=50000, warmup=5000, init.iter=500),
 hll=setup_sim(2^14, 2^12, 6, n_iter=50000, warmup=5000, init.iter=500)
)

# Instructions for run analysis
analyses = analyses(
  commands = commands(
    mcmc = mcmc_sb(..dataset..),
    mcmc2 = mcmc_sd(..dataset..)
    ), 
  datasets = datasets)

# save all instructions
save(datasets, analyses, file='targets.Rdata')
