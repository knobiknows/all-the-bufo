#!/bin/bash

# Set the path to the all-the-bufo folder
bufo_folder="$(pwd)/all-the-bufo"
index_file="index.md"

# Create the index.md file
echo "| name | image |
| - | - |" > "$index_file"

find_image_files() {
    find "$bufo_folder" -type f \( -iname "*.png" -o -iname "*.gif" -o -iname "*.jpeg" \)
}

extract_filename() {
    sed 's|.*/||'
}

format_as_markdown_row() {
    awk '{printf "| %s | ![%s](all-the-bufo/%s) |\n", $0, $0, $0}'
}

find_image_files | sort | extract_filename | format_as_markdown_row >> "$index_file"