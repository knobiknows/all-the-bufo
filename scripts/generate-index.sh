#!/bin/bash

# Set the path to the all-the-bufo folder
bufo_folder="$(pwd)/all-the-bufo"
index_file="index.md"

# Create the index.md file
echo "| name | image |
| - | - |" > "$index_file"

# Initialize an empty array
files=()

# Use find to locate PNG and GIF files, sort them, and read into the array
while IFS= read -r line; do
    files+=("$line")
done < <(find "$bufo_folder" -type f \( -iname "*.png" -o -iname "*.gif" -o -iname "*.jpeg" \) | sort)

# Loop through each image file in the sorted array
for image_file in "${files[@]}"; do
    # Get the file name
    file_name=$(basename "$image_file")

    # Generate the markdown line for the image
    markdown_line="| $file_name | ![$file_name](all-the-bufo/$file_name) |"

    # Append the markdown line to the index.md file
    echo "$markdown_line" >> "$index_file"
done
