#!/bin/bash
#SBATCH --array=0-7
#SBATCH --time=03:00:00
#SBATCH --account=def-rhodin
#SBATCH --job-name=tr_blender_mipnerf
#SBATCH --gres=gpu:v100l:1
#SBATCH --mem=24G
module load StdEnv/2020
module load python/3.8
module load cuda/11 cudnn

cd /home/gxc321/
source MipNerfEnv/bin/activate
cd /home/gxc321/scratch/mipnerf/
export XLA_FLAGS=--xla_gpu_cuda_data_dir=$CUDA_PATH

source scripts/cc_scripts/blender/train_per_task_cc.sh $SLURM_ARRAY_TASK_ID
