#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath "$scripts"/..)

models=$base/models
data=$base/data
tools=$base/tools

mkdir -p "$models"

num_threads=4
device="0"
dropout_values=("0.5")

# Time tracking
SECONDS=0

# Loop through each dropout value
for dropout in "${dropout_values[@]}"; do

    (cd "$tools"/pytorch-examples/word_language_model &&
        CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python main.py --data "$data"/mal_dataset \
            --epochs 1 \
            --log-interval 100 \
            --emsize 650 --nhid 650 --dropout "$dropout" --tied \
            --save "$models"/model_"$dropout".pt \
            --cuda
    )
done

echo "time taken:"
echo "$SECONDS seconds"
