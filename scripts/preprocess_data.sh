#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data

# preprocess slightly

cat $data/mal_dataset/raw/mal_synopsis.txt | python $base/scripts/preprocess_raw.py > $data/mal_dataset/raw/mal_synopsis.cleaned.txt

# tokenize, fix vocabulary upper bound

cat $data/mal_dataset/raw/mal_synopsis.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 75000 --tokenize --lang "en" --sent-tokenize > \
    $data/mal_dataset/raw/mal_synopsis.preprocessed.txt

# split into train, valid and test

head -n 40476 $data/mal_dataset/raw/mal_synopsis.preprocessed.txt | tail -n 40400 > $data/mal_dataset/valid.txt
head -n 80953 $data/mal_dataset/raw/mal_synopsis.preprocessed.txt | tail -n 40400 > $data/mal_dataset/test.txt
tail -n 188889 $data/mal_dataset/raw/mal_synopsis.preprocessed.txt | head -n 188800 > $data/mal_dataset/train.txt
