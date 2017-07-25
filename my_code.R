setup_sim <- function(G, K, V, n_iter, warmup){
  #number of samples
  N <- V*4
  
  #group_id
  group <- rep(1:V, each=4)
  
  #design matrix
  X <- cbind(1, rbind(diag(V-1),0))[group,]
  
  #true base measure
  m <- c(3, rep(0, V-1))
  C <- rWishart(1, V, diag(c(1/V, rep(.1/V, V-1))))[,,1]
  U <- chol(C)
  a <- 1
  b <- 1
  
  #gene specific
  beta <- sapply(1:G, function(g) rnorm(V) %*% U + m)
  sigma <- sapply(1:G, function(g) sqrt(rgamma(1, a, b)))
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
                         idx_save=1:5, n_save_P=1, alpha_fixed=F, slice_width=1, max_steps=100)
  
  #estimates
  est <- indEstimates(d)
  
  list(
    truth = t,
    fdata = d,
    fpriors = p,
    estimates = est,
    control = contr
  )
}

mcmc_sb <- function(input){
  s <- with(input, mcmc(fdata, fpriors, control, estimates = estimates, verbose=0))
  return(s)
}
