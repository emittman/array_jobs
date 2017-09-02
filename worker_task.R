# i = identify the scenario 
# code below produce data, analysis and summary for ONE scenario

ss  = Sys.getenv("SLURM_ARRAY_TASK_ID") 
i = as.numeric(ss) + 1

# 0 ) libraries and functions
pkgs <- c('plyr', 'dplyr', 'tidyr', 'cudarpackage')
lapply(pkgs, library,  character.only = TRUE, quietly=TRUE )

# inputs
load('targets.Rdata')
load('seeds.RData')
source('my_code.R')
set.seed(seeds[i])
# ==================================================
# 1) Create a dataset, run the analysis and its summary
# 1.1 Create data set and save it
eval( parse(text= paste(datasets$target[i], datasets$command[i], sep=' <- ')  ) )
saveRDS(get(datasets$target[i]) , file = paste('datasets/', datasets$target[i], '.rds', sep='') )

# 1.2 Run all analyses that use this dataset
id <- grep(datasets$target[i], analyses$target) 
for (j in id) {
  eval( parse(text= paste(analyses$target[j], analyses$command[j], sep=' <- ')  ) )
  saveRDS(get(analyses$target[j]), file = paste('analyses/', analyses$target[j], '.rds', sep='') )
}

