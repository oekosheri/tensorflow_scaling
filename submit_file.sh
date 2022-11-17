#!/usr/local_rwth/bin/zsh
#SBATCH --time=2:30:00
#SBATCH --partition=c18g
#SBATCH --nodes=tag_node
#SBATCH --ntasks-per-node=tag_task
#SBATCH --cpus-per-task=tag_cpu
#SBATCH --gres=gpu:tag_task
#SBATCH --account=rwth1223

localDir=`pwd`

module load cuda/11.2
module load cudnn/8.2.1


source ~/.zshrc
conda activate tensor_new


module list
echo "SLURM_JOB_NODELIST: ${SLURM_JOB_NODELIST}"
echo "R_WLM_ABAQUSHOSTLIST: ${R_WLM_ABAQUSHOSTLIST}"
echo "SLURMD_NODENAME: ${SLURMD_NODENAME}"



# commands to run
comm_1="${MPIEXEC} ${FLAGS_MPI_BATCH} zsh -c '\
source setup.sh  && bash script.sh'"

comm_2="source setup.sh && bash script.sh"


command=tag_command


if [ $command = 1 ]

then
    
    eval  "${comm_1}"
    
else
    
    eval  "${comm_2}"
    
fi

# save the log file
cp log.csv  ../Logs/log_${SLURM_NTASKS}.csv


