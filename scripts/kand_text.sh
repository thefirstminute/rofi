#!/bin/bash

# Path to your directory containing text snippets
SNIPPETS_DIR="$HOME/Documents/canned_text"

# Get a list of snippet files
snippets=("$SNIPPETS_DIR"/*)

# Use Rofi to select a snippet
selected=$(for snippet in "${snippets[@]}"; do echo "$(basename "$snippet")"; done | rofi -dmenu -i -p "Canned Text")

# If a snippet is selected, insert it at the current cursor position
if [ -n "$selected" ]; then
    # Get the content of the selected snippet
    snippet_content=$(cat "$SNIPPETS_DIR/$selected")

    # Insert the snippet at the current cursor position
    xdotool type --clearmodifiers "$snippet_content"
fi

