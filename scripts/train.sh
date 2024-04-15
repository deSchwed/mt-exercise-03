#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools

mkdir -p $models

num_threads=4
device="0"

SECONDS=0


(cd $tools/pytorch-examples/word_language_model &&
    CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python main.py --data $data/mal_dataset \
        --epochs 40 \
        --log-interval 100 \
        --emsize 650 --nhid 650 --dropout 0.3 --tied \
        --save $models/model.pt \
        --cuda
)

echo "time taken:"
echo "$SECONDS seconds"
