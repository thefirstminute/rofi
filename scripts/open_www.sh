#!/bin/bash

local file
file=$(find /var/www/html/ -type f | rofi -dmenu -i -p "Select a file:")

# Check if a file was selected.
if [ -n "$file" ]; then
  nvim "$file"
else
  echo "No file selected."
fi
