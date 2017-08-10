#working directory is assumed to be array_jobs/summaries/

dir.create(file.path("data"))

library(plyr)
df <- ldply(c("sss","ssm","ssl","sms","smm","sml"), function(f) {
  file <- paste("../analyses/", "mc_sb_", f, ".rds", sep = "")
  dat <- readRDS(file)
  len <- length(dat[[1]][["alpha"]])
  data.frame(which.sim=f, t(summary(dat[[1]][["alpha"]][10000:len])))
})

saveRDS(df, "summaries_alpha.rds")
