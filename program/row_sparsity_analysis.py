# Import necessary libraries
import numpy as np

# Read the file into a list of hex strings
with open('../test_code/image/image_10.txt', 'r') as file:
    hex_data = file.readlines()

# Strip any extraneous whitespace or newline characters
hex_data = [line.strip() for line in hex_data]

# Convert hex strings to integers
int_data = [int(line, 16) for line in hex_data]

# Group data by the remainder when index is divided by 784
grouped_data = {}
for index, value in enumerate(int_data):
    remainder = index % 784
    if remainder not in grouped_data:
        grouped_data[remainder] = []
    grouped_data[remainder].append(value)

# Count the number of groups where all values are 0
zero_groups_count = sum(1 for group in grouped_data.values() if all(val == 0 for val in group))

print('The number of groups where all values are 0: %d', zero_groups_count)