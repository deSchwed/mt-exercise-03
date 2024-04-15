import pandas as pd
import random


# Read in csv file containing anime dataset
df_anime = pd.read_csv('../data/mal_dataset/raw/anime.csv', encoding='utf-8')
# Drop rows where the 'synopsis' column has NaN
df_anime_cleaned = df_anime.dropna(subset=['synopsis'])
del df_anime

# Read in csv file containing anime dataset
df_manga = pd.read_csv('data/mal_dataset/raw/manga.csv', encoding='utf-8')
# Drop rows where the 'synopsis' column has NaN
df_manga_cleaned = df_manga.dropna(subset=['synopsis'])
del df_manga

# Set containing all entries
synopsis_set = set(df_anime_cleaned['synopsis']).union(set(df_manga_cleaned['synopsis']))

del df_anime_cleaned
del df_manga_cleaned

print(f"Total unique synopsis entries: {len(synopsis_set)}")
# Shuffle the set
synopsis_list = list(synopsis_set)
del synopsis_set

random.shuffle(synopsis_list)

with open('../data/mal_dataset/raw/mal_synopsis.txt', 'w', encoding='utf-8') as output:
    for synopsis in synopsis_list:
        output.write(synopsis + '\n')