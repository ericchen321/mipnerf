#!/bin/bash

CONFIG=$1
DATASET=$2
SCENE=$3
RENDER_EVERY=$4

if [ $DATASET == "blender" ]; then
  DATA_DIR="data/nerf_synthetic/${SCENE}/"
elif [ $DATASET == "llff" ]; then
  DATA_DIR="data/nerf_llff_data/${SCENE}/"
else
  echo "Error! Dataset name not recognized"
  exit 1
fi

TRAIN_DIR="workspace/${CONFIG}_${SCENE}"
LOG_FILENAME="$TRAIN_DIR/train.log"

mkdir -p $TRAIN_DIR
rm $TRAIN_DIR/*

set -x
python -u -m train \
  --data_dir=$DATA_DIR \
  --train_dir=$TRAIN_DIR \
  --gin_file=configs/${CONFIG}.gin \
#   --gin_param="Config.batch_size = 1024" \
#   --gin_param="Config.max_steps = 400" \
#   --gin_param="Config.save_every = 100" \
  --render_every=$RENDER_EVERY \
  --chunk=1024 \
  --logtostderr 2>&1 | tee $LOG_FILENAME