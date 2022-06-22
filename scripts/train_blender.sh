#!/bin/bash
# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Script for training on the Blender dataset.

EXPERIMENT="$1"
SCENE="$2"
WORK_DIR="workspace"
TRAIN_DIR="$WORK_DIR/$EXPERIMENT/$SCENE"
DATA_DIR="data/nerf_synthetic/$SCENE"
LOG_FILENAME="$TRAIN_DIR/${SCENE}_train.log"

mkdir -p $TRAIN_DIR
rm $TRAIN_DIR/*

python -u -m train \
  --data_dir=$DATA_DIR \
  --train_dir=$TRAIN_DIR \
  --gin_file=configs/blender.gin \
  --gin_param="Config.batch_size = 1024" \
  --gin_param="Config.max_steps = 10000" \
  --gin_param="Config.save_every = 100" \
  --render_every 200 \
  --chunk 1024 \
  --logtostderr 2>&1 | tee $LOG_FILENAME
