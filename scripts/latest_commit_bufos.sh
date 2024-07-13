#!/bin/bash

# Get the list of new bufos
latest_bufos=$(git diff-tree --no-commit-id --name-only -r HEAD HEAD~)

# Convert latest_files to an array
IFS=$'\n' read -rd '' -a latest_bufos_array <<<"$latest_bufos"

# Delete all bufos in the all-the-bufo directory that are not in the latest commit
for file in $(find ./all-the-bufo -type f -name '*.png'); do
    relative_bufos=${file#./}
    if [[ ! "${latest_bufos_array[*]}" =~ "${relative_bufo}" ]]; then
        rm "$file"
    fi
done

echo "Only bufos from the latest commit remain."

