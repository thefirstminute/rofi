#!/bin/bash

# Path to your directory containing text snippets
BASE_SNIPPETS_DIR="$HOME/snippets"

# Use Rofi to select a subfolder
selected_subfolder=$(ls "$BASE_SNIPPETS_DIR" | rofi -dmenu -i -p "Select Category")

# If a subfolder is selected, proceed with snippet selection
if [ -n "$selected_subfolder" ]; then
    SNIPPETS_DIR="$BASE_SNIPPETS_DIR/$selected_subfolder"

    # Get a list of snippet files
    snippets=("$SNIPPETS_DIR"/*)

    # Use Rofi to select a category
    selected_category=$(for snippet in "${snippets[@]}"; do echo "$(basename "$snippet")"; done | rofi -dmenu -i -p "Select Snippet" -matching fuzzy -lines 25)

    # If a category is selected, insert it at the current cursor position
    if [ -n "$selected_category" ]; then

      ## if we passed a varaible cat it out, this is a hack to call within vim
      if [[ -z "$1" ]]; then
        # Get the content of the selected snippet
        snippet_contenr=$(cat "$SNIPPETS_DIR/$selected_category")

        # Insert the snippet at the current cursor position
        xdotool type --clearmodifiers "$snippet_content"
      else
        cat "$SNIPPETS_DIR/$selected_category"
      fi
    fi
fi



