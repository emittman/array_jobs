#!/bin/bash
#SBATCH --time=72:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=16   # 16 processor core(s) per node 
#SBATCH --partition=gpu    # gpu node(s)
#SBATCH --mail-user=emittman@iastate.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
export LD_LIBRARY_PATH="/usr:/usr/local:/usr/local/cuda-8.0:/usr/local/cuda-8.0/lib64"
module load R
cd /home/emittman/array_jobs/explore
R --vanilla CMD BATCH longtest.R