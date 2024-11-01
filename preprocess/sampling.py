import numpy as np # type: ignore
from collections import defaultdict
scores = []
parts_0 = []
score_map = defaultdict(list)
with open("./preprocess/output.txt", "r") as pairs:
    for line in pairs:
        parts = line.strip().split()
        score = float(parts[1])
        scores.append(parts[1])
        part_0 = parts[0]
        score_map[score].append(part_0)
        
gaussian_sample = []
train_data_len = len(scores)
while len(gaussian_sample) < 0.9 * train_data_len:
    new_sample = np.random.normal(np.mean(scores), np.std(scores))
    if(new_sample>1):
        continue
    gaussian_sample.append(new_sample)

new_train = []
for i in gaussian_sample:
    closest_score = min(scores, key=lambda x: abs(x - i))
    closest_parts_0 = score_map[closest_score]
    new_train.extend(closest_parts_0)
    del score_map[closest_score]
    scores = [s for s in scores if s != closest_score]
    parts_0 = [p for s, p in zip(scores, parts_0) if s != closest_score]
    if len(new_train) >= 0.9*train_data_len:
        break

with open("./dataset/HumanML3D/train.txt", "w") as train_file:
    for part_0 in new_train:
        train_file.write(f"{part_0}\n")