#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath "$scripts"/..)

models=$base/models
data=$base/data
tools=$base/tools
samples=$base/samples

# Change this to the specific version of the model you want to generate with
model_name="model_0.3"

mkdir -p "$samples"

num_threads=4
device="0"

(cd "$tools"/pytorch-examples/word_language_model &&
    CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python generate.py \
        --data "$data"/mal_dataset \
        --words 100 \
        --checkpoint "$models"/"$model_name".pt \
        --outf "$samples"/sample \
        --cuda
)

# Function to determine the next available file index
function find_next_index {
    local base_path=$1
    local model_name=$2
    local index=0

    # Loop to find the next available index
    while [ -f "${base_path}/sample_${model_name}_${index}" ]; do
        index=$((index + 1))
    done
    echo $index
}

# Calculate next index
next_index=$(find_next_index "$samples" "$model_name")

# Rename the generated sample file
mv "$samples"/sample "$samples"/sample_"$model_name"_"$next_index"
