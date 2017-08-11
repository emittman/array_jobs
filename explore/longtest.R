#single long job "highest settings", i.e. G=40000, V=6, K=8000
library(cudarpackage)

source("../my_code.R")

set.seed(081017)

setup <- setup_sim(40000, 8000, 6, 100000, 1)

saveRDS(setup, "truth.rds")

dir.create(file.path("misc"))

#contr <- formatControl(n_iter=n_iter, thin=1, warmup=warmup, methodPi="stickBreaking",
#                      idx_save=1, n_save_P=1, alpha_fixed=F, slice_width=1, max_steps=100)

#mcmc_sb <- function(input){
#  s <- with(input, mcmc(fdata, fpriors, control, estimates = estimates, verbose=0))
#  return(s)
#}

warmup_cycles <- as.integer(10)

warmup_length <- as.integer(5000)

final_length <- as.integer(30000)

chain <- initFixedGrid(setup$fpriors, setup$estimates)

for(i in warmup_cycles){
  setup$control$n_iter <- warmup_length
  setup$control$warmup <- as.integer(1)
  s <- with(setup, mcmc(fdata, fpriors, control, chain, estimates))
  saveRDS(s, file=paste("misc/wrm-up-cycle-",i,".rds", sep=""))
  zeta <- with(setup, as.integer(sample(fpriors$K, fdata$G, replace=T) - 1))
  id <- order(s[['state']]$pi, decreasing=TRUE)
  chain <- with(s[['state']], formatChain(beta[,id], exp(pi[id]), tau2[id], zeta, alpha))
}

setup$control$n_iter <- final_length
setup$control$warmup <- as.integer(1)
s <- with(setup, mcmc(fdata, fpriors, control, chain, estimates))
saveRDS(s, "misc/final_run.rds")

