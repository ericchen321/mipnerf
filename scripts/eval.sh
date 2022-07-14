#!/bin/bash

CONFIG=$1
DATASET=$2
SCENE=$3

if [ $DATASET == "blender" ]; then
  DATA_DIR="data/nerf_synthetic/${SCENE}/"
elif [ $DATASET == "llff" ]; then
  DATA_DIR="data/nerf_llff_data/${SCENE}/"
else
  echo "Error! Dataset name not recognized"
  exit 1
fi

TRAIN_DIR="workspace/${CONFIG}_${SCENE}"
LOG_FILENAME="$TRAIN_DIR/eval.log"

python -u -m eval \
  --data_dir=$DATA_DIR \
  --train_dir=$TRAIN_DIR \
  --chunk=1024 \
  --gin_file=configs/${CONFIG}.gin \
  --eval_once \
  --save_output \
  --logtostderr 2>&1 | tee $LOG_FILENAME