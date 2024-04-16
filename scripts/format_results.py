import os
import pandas as pd
import matplotlib.pyplot as plt

# Define path to logs directory
log_dir = '../logs'

# Initialize empty DataFrame
all_data = pd.DataFrame()

# Iterate over each file in the logs directory
for filename in os.listdir(log_dir):
    if filename.endswith('.txt'):
        # Extract dropout value from filename
        dropout = float(filename.split('_')[1].replace('.txt', ''))

        # Prepare to read log file
        path = os.path.join(log_dir, filename)
        with open(path, 'r', encoding='utf-8') as logfile:
            epochs = []
            perplexities = []
            for line in logfile:
                if "end of epoch" in line:
                    parts = line.split('|')
                    epoch = int(parts[1].strip().split()[3])
                    ppl = float(parts[4].strip().split()[2])
                    epochs.append(epoch)
                    perplexities.append(ppl)

        # Create a DataFrame for the current file
        df = pd.DataFrame({
            'Epoch': epochs,
            'Perplexity': perplexities,
            'Dropout': [dropout] * len(epochs)
        })
        # Append to main DataFrame
        all_data = pd.concat([all_data, df], ignore_index=True)

# Pivot the DataFrame for easier plotting
pivot_df = all_data.pivot(
    index='Epoch', columns='Dropout', values='Perplexities')

# Save the DataFrame in a table-like format
pivot_df.to_csv('../plots/output_table.txt', sep='\t', index=True, header=True)

# Plotting
plt.figure(figsize=(10, 6))
for column in pivot_df.columns:
    plt.plot(pivot_df.index, pivot_df[column], label=f'Dropout {column}')

plt.title('Perplexity by Epoch for Different Dropout Values')
plt.xlabel('Epoch')
plt.ylabel('Perplexity')
plt.legend(title='Dropout')
plt.grid(True)
plt.savefig('../plots/preplexity_plot.png', dpi=500, bbox_inches='tight')
