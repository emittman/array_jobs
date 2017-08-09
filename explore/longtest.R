#single long job "highest settings", i.e. G=40000, V=6, K=8000
setup <- setup_sim(40000, 8000, 6, 120000, 1)

dir.create(file.path("misc"))

samples <- mcmc_sb(setup)

saveRDS(sample, "misc/longtest.rds")

  