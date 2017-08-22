#working directory is assumed to be array_jobs/summaries/

dir.create(file.path("data"))

library(coda)
library(plyr)

df <- ldply(c("sss","ssm","ssl","sms","smm","sml","sls","slm","sll",
              "lss","lsm","lsl","lms","lmm","lml","lls","llm","lll"), function(f) {
  file <- paste("../analyses/", "mcmc_", f, ".rds", sep = "")
  dat <- readRDS(file)
  len <- length(dat[[1]][["alpha"]])
  d <- data.frame(which.sim=f, #t(as.numeric(summary(dat[[1]][["alpha"]][20000:len]))),
                  effectiveSize(mcmc(dat[[1]][["alpha"]])),
                  dat[[4]],
                  len)
  names(d)[2:4] <- c(#"min","q1","median","mean","q3","max",
    "n_eff","time","mcmc_iter")
  d
})

saveRDS(df, "summaries_alpha.rds")

df <- ldply(c("sss","ssm","ssl","sms","smm","sml","sls","slm","sll",
              "lss","lsm","lsl","lms","lmm","lml","lls","llm","lll"), function(f) {
                file <- paste("../analyses/", "mcmc_", f, ".rds", sep = "")
                dat <- readRDS(file)
                nocc <- dat[[1]][["num_occupied"]]
                q <- quantile(nocc, c(.05,.5,.9))
                d <- data.frame(which.sim=f, #t(as.numeric(summary(dat[[1]][["alpha"]][20000:len]))),
                                lower = q[1],
                                median = q[2],
                                upper = q[3])
                d
              })

saveRDS(df, "summaries_num_occ.rds")

df <- ldply(c("sss","ssm","ssl","sms","smm","sml","sls","slm","sll",
              "lss","lsm","lsl","lms","lmm","lml","lls"), function(f) {
                file <- paste("../analyses/", "mcmc2_", f, ".rds", sep = "")
                dat <- readRDS(file)
                len <- length(dat[[1]][["alpha"]])
                d <- data.frame(which.sim=f, #t(as.numeric(summary(dat[[1]][["alpha"]][20000:len]))),
                                effectiveSize(mcmc(dat[[1]][["alpha"]])),
                                dat[[4]],
                                len)
                names(d)[2:4] <- c(#"min","q1","median","mean","q3","max",
                  "n_eff","time","mcmc_iter")
                d
              })

saveRDS(df, "summaries_alpha2.rds")

df <- ldply(c("sss","ssm","ssl","sms","smm","sml","sls","slm","sll",
              "lss","lsm","lsl","lms","lmm","lml","lls"), function(f) {
                file <- paste("../analyses/", "mcmc2_", f, ".rds", sep = "")
                dat <- readRDS(file)
                nocc <- dat[[1]][["num_occupied"]]
                q <- quantile(nocc, c(.05,.5,.9))
                d <- data.frame(which.sim=f, #t(as.numeric(summary(dat[[1]][["alpha"]][20000:len]))),
                                lower = q[1],
                                median = q[2],
                                upper = q[3])
                d
              })

saveRDS(df, "summaries_num_occ2.rds")
# df2 <- llply(c("sss","ssm","ssl","sms","smm","sml","sls","slm","sll",
#                "lss","lsm","lsl","lms","lmm","lml","lls","llm"), function(f) {
#   file <- paste("../datasets/", f, ".rds", sep = "")
#   dat_truth <- readRDS(file)
#   file2 <- paste("../analyses/", "mc_sb_", f, ".rds", sep = "")
#   dat_est <- readRDS(file2)
#   truth <- t(dat_truth)
#   ind_estimates <- t(dat_truth$est)
#   d <- data.frame())