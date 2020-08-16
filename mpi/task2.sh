#!/bin/bash
# Created by the University of Melbourne job script generator for SLURM
# Sun Apr 12 2020 02:23:05 GMT+1000 (Australian Eastern Standard Time)

# Partition for the job:
#SBATCH --partition=cloud

# The name of the job:
#SBATCH --job-name="task2"

# The project ID which this job should run under:
#SBATCH --account="COMP90024"

# Maximum number of tasks/CPU cores used by the job:
#SBATCH --ntasks=8



# Send yourself an email when the job:
# aborts abnormally (fails)
#SBATCH --mail-type=FAIL
# begins
#SBATCH --mail-type=BEGIN
# ends successfully
#SBATCH --mail-type=END

# Use this email address:
#SBATCH --mail-user=jainu@student.unimelb.edu.au

# The maximum running time of the job in days-hours:mins:sec
#SBATCH --time=0-3:0:00

# The number of nodes
#SBATCH --nodes=1

# CPUs per task
#SBATCH --cpus-per-task=1

# check that the script is launched with sbatch
if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi

# Run the job from the directory where it was launched (default)

# The modules to load:
module load Python/3.4.3-goolf-2015a

# The job command(s):
mpirun -np 8 python bigRunner.py