#!/bin/bash
#SBATCH --array=0
#SBATCH --time=06:00:00
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
source scripts/train.sh blender_paper_cc blender lego

declare -a scene_names=(
    "lego"
    # "chair"
    # "drums"
    # "ficus"
    # "hotdog"
    # "materials"
    # "mic"
    # "ship"
    )

for shape_name in ${shape_names[@]}; do
    source scripts/train.sh $SLURM_ARRAY_TASK_ID blender blender $shape_name 50000
done