# MT Exercise 3: Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model). Thanks to Emma van den Bold, the original author of these scripts. 

# Changes made
Based off of the [original repo](https://github.com/siri-web/mt-exercise-03), the following changes were made:
- Added a new script `convert_csv.py` to convert two csv files from the chosen dataset into a single text file.
- Added a new script `preprocess_data.sh` to preprocess the data and split it into training, validation, and test sets. (Based off of the original `download_data.sh`)
- Added a new script `train_all.sh` to train several models with different hyperparameters. **Uses CUDA**
- Changed `install_packages.sh` to install additional packages (pandas and matplotlib) used in the new/changed scripts.
- Changed `preproces.py` to not escape XML unfriendly characters.
- Changed the `main.py` script from the pytorch example to save the logs to a log file in the `logs` directory.
- Changed the `generate.sh` script to dynamically change the output file name based on the model being used and existing samples from that model.

# Usage
First create the virtual environment and install the required packages with the scripts provided from the original repo. Rename `PLACE_IN_PYTORCH_FOLDER_main.py` to `main.py` and replace the script from the `word_language_model` folder inside `tools/pytorch-examples`.

Next, download the dataset from [Kaggle](https://www.kaggle.com/datasets/andreuvallhernndez/myanimelist) and place the `anime.csv` and `manga.csv` files in the `data` directory.
*Note: The filepaths are hardcoded in the `convert_csv.py` script.*

Then, run the following commands to preprocess the data and train the models:
```bash
python -m ./scripts/convert_csv.py
./scripts/preprocess_data.sh
./scripts/train_all.sh
```

Generate samples from the trained models with the `generate.sh` script, make sure to specify the model you want to generate samples from inside the script.

Lastly, run the following command to create a table and a line graph of the perplexity scores from the log-files found in `logs`:
```bash
python ./scripts/format_results.py
```

You will find a tabular representation of the results in `plots/output_table.txt` and a line graph in `plots/perplexity_plot.png`.

# Notes on Usage
With the current setup, running `train_all.sh` and training all models will take a **very** long time on a CPU. It took me around 1 hour per model on my machine, which has an RTX 4080 GPU, and 128 GB of RAM.