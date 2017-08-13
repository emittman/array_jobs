setup_sim <- function(G, K, V, n_iter, warmup, init.iter){
  #number of samples
  N <- V*4 #assume 4 samples of each type
  
  #group_id
  group <- rep(1:V, each=4)
  
  #design matrix
  X <- cbind(1, rbind(diag(V-1),0))[group,]
  
  #distribution of clusters
  m <- rep(0, V)
  C <- diag(3/(1:V)^2)
  U <- chol(C)
  a <- 1
  b <- 1
  
  #make clusters
  t_K <- floor(sqrt(G))
  betaC <- sapply(1:t_K, function(g) rnorm(V) %*% U + m)
  sigmaC <- sapply(1:t_K, function(g) sqrt(rgamma(1, a, b)))
  
  #cluster assignments
  z <- sample(1:t_K, size = G, replace=T)
  
  #DONT jitter genes
  beta <- betaC[,z] #+ sapply(1:G, function(g) rnorm(V) %*% U/10)
  sigma <- sigmaC[z] #+ rnorm(G, 0, b/a/4)
  param <- rbind(beta, 1/sigma^2)
  row.names(param) <- c(sapply(1:V, function(v) paste(c("beta",v), collapse="")), "tau2")
  
  #priors
  p <- formatPriors(K = K, prior_mean = m,
                         prior_sd = sqrt(diag(C)),
                         a = a,
                         b = b,
                         A=3, B=3/G^.5) #scaled to the size of the data set
  
  #data
  y <- t(sapply(1:G, function(g) rnorm(N, X %*% beta[,g], sigma[g])))
  d <- formatData(y, X, transform_y=identity)
  
  #truth
  t <- list(
    param=param,
    m=m, C=C, a=a, b=b
  )

  contr <- formatControl(n_iter=n_iter, thin=1, warmup=warmup, methodPi="stickBreaking",
                         idx_save=1, n_save_P=1, alpha_fixed=F, slice_width=1, max_steps=100)
  
  #estimates
  est <- indEstimates(d)
  
  #starting values
  init.chain <- initFixedGrid(p, est)
  
  #pilot chain to get good initial value
  init.contr <- contr
  init.contr$n_iter <- as.integer(init.iter)
  init.contr$warmup <- as.integer(1)
  s.init <- mcmc(d, p, init.contr, init.chain, est)
  zeta <- as.integer(sample(p$K, d$G, replace=T) - 1)
  id <- order(s.init[['state']]$pi, decreasing=TRUE)
  c <- with(s.init[['state']], formatChain(beta[,id], exp(pi[id]), tau2[id], zeta, alpha))
  
  
  list(
    truth = t,
    data = d,
    chain = c,
    priors = p,
    estimates = est,
    control = contr
  )
}

mcmc_sb <- function(input){
  s <- with(input, mcmc(data, priors, control, chain, estimates = estimates, verbose=0))
  return(s)
}
