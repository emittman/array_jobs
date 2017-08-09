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