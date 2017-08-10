#working directory is assumed to be array_jobs/summaries/

dir.create(file.path("data"))

library(coda)
library(plyr)

df <- ldply(c("sss","ssm","ssl","sms","smm","sml"), function(f) {
  file <- paste("../analyses/", "mc_sb_", f, ".rds", sep = "")
  dat <- readRDS(file)
  len <- length(dat[[1]][["alpha"]])
  d <- data.frame(which.sim=f, t(as.numeric(summary(dat[[1]][["alpha"]][20000:len]))),
                  effectiveSize(mcmc(dat[[1]][["alpha"]][20000:len])),
                  dat[[4]])
  names(d)[2:7] <- c("min","q1","median","mean","q3","max","n_eff","time")
})

saveRDS(df, "summaries_alpha.rds")
