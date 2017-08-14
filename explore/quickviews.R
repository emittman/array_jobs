#working directory is assumed to be array_jobs/analysis/

traceSmth <- function(filename, range, th){
  file <- paste(normalizePath(dirname(filename)),"/", filename, ".rds", sep = "")
  s <- readRDS(file)
  len <- length(s[[1]][[th]])
  stopifnot(is.null(range) | (length(range)==2 & range[1]>=1 & range[1]<range[2] & range[2] < len))
  require(coda)
  if(is.null(range)){
    id <- 1:len
  } else {
    id <- range[1]:range[2]
  }
  cat(paste("traceplot for ", th, ", range: [", id[1], ",", id[len], "]", sep=""))
  cat(paste("length: ", len, "\n", sep=""))
  traceplot(mcmc(s[[1]]$alpha[id]), ylab = th)
}

traceAlpha <- function(filename, range=NULL){
  traceSmth(filename, range, "alpha")
}

traceNumOcc <- function(filename, range=NULL){
  traceSmth(filename, range, "num_occupied")
}

traceMaxId <- function(filename, range=NULL){
  traceSmth(filename, range, "max_id")
}

plot_means <- function(filename, which.means, dims=c(1,2), truth=TRUE, both=FALSE){
  stopifnot(length(dims)==2)
  print(cat("run from analyses/ directory\n"))
  mcout <- readRDS(paste("mcmc_",filename,".rds",sep=""))$summaries$means_betas
  true <- readRDS(paste("../datasets/",filename,".rds",sep=""))$truth$param
  ols <- readRDS(paste("../datasets/",filename,".rds",sep=""))$estimates$beta
  
  stopifnot(min(dims)>0, max(dims) <= dim(mcout)[1])
  stopifnot(all(which.means<=dim(mcout)[2]))
  if(truth){
    plot(t(true[dims,which.means]))
  } else {
    plot(t(ols[dims,which.means]))
  }
  if(truth&both){
    plot(t(true[dims,]),pch=21)
    points(t(true[dims,which.means]),pch=21, bg=1)
    points(t(ols[dims,which.means]), pch=23, col="green", bg="green")
  }
  require(scales)
  points(t(mcout[dims,which.means]), col=alpha("red",.5), bg=alpha("red",.5))
}
