# MT Exercise 3: Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model). Thanks to Emma van den Bold, the original author of these scripts. 

# Changes made
Based off of the [original repo](https://github.com/siri-web/mt-exercise-03), the following changes were made:
- Added a new script `convert_csv.py` to convert two csv files from the chosen dataset into a single text file.
- Added a new script `preprocess_data.sh` to preprocess the data and split it into training, validation, and test sets. (Based off of the original `download_data.sh`)
- Added a new script `train_all.sh` to train several models with different hyperparameters.
- Changed `preproces.py` to not escape XML unfriendly characters.
- Changed the `main.py` script from the pytorch example to save the logs to a log file in the `logs` directory.