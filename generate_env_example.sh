#!/bin/bash

SOURCE_FILE=".devcontainer/.env"
TARGET_FILE=".devcontainer/.env.example"

# Check if the source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Source file $SOURCE_FILE does not exist."
    exit 1
fi

# Clear the target file
> "$TARGET_FILE"
echo "Cleared $TARGET_FILE."

# Create the target file
while IFS= read -r line || [[ -n "$line" ]]; do
  if [[ "$line" =~ ^[[:space:]]*$ ]]; then
    echo "" >> "$TARGET_FILE"
  elif [[ "$line" =~ ^[[:space:]]*# ]]; then
    echo "$line" >> "$TARGET_FILE"
  elif [[ "$line" =~ ^[[:space:]]*([A-Za-z_][A-Za-z0-9_]*)= ]]; then
    key=$(echo "$line" | cut -d= -f1)
    echo "${key}=\"\"" >> "$TARGET_FILE"
  else
    echo "$line" >> "$TARGET_FILE"
  fi
done < "$SOURCE_FILE"
echo "Generated $TARGET_FILE successfully."

