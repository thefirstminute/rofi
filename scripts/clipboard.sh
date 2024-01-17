#!/bin/bash

# Clipboard folder
CLIPBOARD_DIR="$HOME/.config/rofi/clipboard"

# Maintenance: Remove files older than 7 days
find "$CLIPBOARD_DIR" -type f -mtime +7 -delete

# Get user choice
choice=$(echo -e "Paste\nCopy\nDelete" | rofi -dmenu -i -p "Clipboard Options")

case "$choice" in
    "Paste")
        # Get the list of clipboard files
        clipboard_files=$(ls "$CLIPBOARD_DIR")

        if [ -n "$clipboard_files" ]; then
            # Let the user choose a file to paste from
            selected_file=$(echo "$clipboard_files" | rofi -dmenu -i -p "Select file to paste from")
            
            if [ -n "$selected_file" ]; then
                # Paste the content of the selected file
                xdotool type --clearmodifiers "$(cat "$CLIPBOARD_DIR/$selected_file")"
            else
                echo "No file selected."
            fi
        else
            echo "Clipboard is empty."
        fi
        ;;
    "Copy")
        # Get the currently selected text or clipboard content
        selected_text=$(xsel -o)
        if [ -z "$selected_text" ]; then
            # If no selected text, use the latest clipboard file
            selected_text=$(cat "$CLIPBOARD_DIR/$(ls -t "$CLIPBOARD_DIR" | head -n 1)")
        fi

        # Generate a unique file name
        file_name=$(echo "$selected_text" | head -c 50 | tr -cd '[:alnum:]' | tr '[:upper:]' '[:lower:]' | sed 's/ *$//g' | sed 's/ /_/g')
        if [ -z "$file_name" ]; then
            # If the generated name is empty, use a default
            file_name="clipboard_$(date +%Y%m%d%H%M%S)"
        fi

        # Save the selected text to a file
        echo "$selected_text" > "$CLIPBOARD_DIR/$file_name"
        echo "Text copied to clipboard: $file_name"
        ;;
    "Delete")
        # Allow the user to choose a file to delete
        file_to_delete=$(ls "$CLIPBOARD_DIR" | rofi -dmenu -i -p "Select file to delete")
        if [ -n "$file_to_delete" ]; then
            rm "$CLIPBOARD_DIR/$file_to_delete"
            echo "File deleted: $file_to_delete"
        fi
        ;;
    *)
        echo "Invalid choice."
        ;;
esac

