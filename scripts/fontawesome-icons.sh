#!/bin/bash

# FAK no workies!!

# Path to Font Awesome CSS file
FONTAWESOME_CSS="/usr/share/fonts-font-awesome/css/font-awesome.css"

# Extract the icon names from the CSS file
icons=$(grep -o -E '\.fa-[a-zA-Z0-9_-]+:before' "$FONTAWESOME_CSS" | sed 's/.fa-\(.*\):before/\1/')

# Use Rofi to search and select an icon
selected_icon=$(echo "$icons" | rofi -dmenu -i -p "Search Font Awesome Icons")

# If an icon is selected, display its Unicode content
if [ -n "$selected_icon" ]; then
  unicode_content=$(grep -o -E "\.fa-$selected_icon:before { content: \"\\(.+\\)\"; }" "$FONTAWESOME_CSS" | sed 's/\.fa-'$selected_icon':before { content: "\\(.*\\)"; }/\1/')
  echo "Selected Icon Unicode Content: $unicode_content"
fi


exit
# #
# #
# # Path to Font Awesome CSS file
# FONTAWESOME_CSS="/usr/share/fonts-font-awesome/css/font-awesome.css"
#
# # Extract the icon names and their Unicode content from the CSS file
# icons_and_content=$(grep -o -E '\.fa-[a-zA-Z0-9_-]+:before { content: "\\(.+\\)"; }' "$FONTAWESOME_CSS" | sed 's/\.fa-\(.*\):before { content: "\\(.*\\)"; }/\1 \2/')
#
# # Use Rofi to search and select an icon
# selected_line=$(echo "$icons_and_content" | rofi -dmenu -i -p "Search Font Awesome Icons")
#
# # If a line is selected, extract the icon name and Unicode content
# if [ -n "$selected_line" ]; then
#   selected_icon=$(echo "$selected_line" | awk '{print $1}')
#   unicode_content=$(echo "$selected_line" | awk '{print $2}')
#
#               # Display the selected icon and its Unicode content
#               echo "Selected Icon: $selected_icon"
#               echo "Unicode Content: $unicode_content"
# fi
#
