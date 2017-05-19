#! /bin/bash
#SBATCH --time=1:00:00
#SBATCH --nodes=2 #request one node
#SBATCH --ntasks-per-node=16
#SBATCH --partition=gpu
#SBATCH --error=msg/array%a.err
#SBATCH --output=msg/array%a.out
#SBATCH --mail-user=emittman@iastate.edu   # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module load R

R --no-save < worker_task.R #run an R script using R
