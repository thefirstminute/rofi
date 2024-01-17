#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Info:
#   author:    Miroslav Vidovic
#   file:      web-search.sh
#   created:   24.02.2017.-08:59:54
#   revision:  ---
#   version:   1.0
# -----------------------------------------------------------------------------
# Requirements:
#   rofi
# Description:
#   Use rofi to search the web.
# Usage:
#   web-search.sh
# -----------------------------------------------------------------------------
# Script:

declare -A URLS

URLS=(
  ["psearch:duckduckgo"]="https://www.duckduckgo.com/?q="
  ["psearch:startpage"]="https://www.startpage.com/do/search?query="
  ["psearch:qwant"]="https://www.qwant.com/?q="
  ["search:google"]="https://www.google.com/search?q="
  ["search:bing"]="https://www.bing.com/search?q="
  ["search:yahoo"]="https://search.yahoo.com/search?p="
  ["search:yandex"]="https://yandex.ru/yandsearch?text="
  ["search:perplexity"]="https://www.perplexity.ai/search?q="

  ["code:github"]="https://github.com/search?q="
  ["code:manpages"]="https://manpages.org/"
  ["code:stackoverflow"]="http://stackoverflow.com/search?q="
  ["code:searchcode"]="https://searchcode.com/?q="
  ["code:openhub"]="https://www.openhub.net/p?ref=homepage&query="
  ["code:superuser"]="http://superuser.com/search?q="
  ["code:askubuntu"]="http://askubuntu.com/search?q="
  ["code:softwareengineering"]="https://softwareengineering.stackexchange.com/search?q="
  ["code:cheatography"]="https://cheatography.com/explore/search/?q="

  ["image:yandex"]="https://yandex.ru/yandsearch?text="
  ["image:coolors"]="https://coolors.co/palettes/trending/"
  ["image:pixabay"]="https://pixabay.com/photos/search/"
  ["image:emoticon"]="https://emoticoncentral.com/search/"

  ["video:youtube"]="https://www.youtube.com/results?search_query="
  ["video:videezy"]="https://www.videezy.com/free-video/"
  ["video:vimeo"]="https://vimeo.com/search?q="
  ["video:bitchute"]="https://www.bitchute.com/search/?query="
  ["video:dailymotion"]="https://www.dailymotion.com/search/"
  ["video:peertube"]="https://peertube.tv/search?search="
  ["video:dtube"]="https://d.tube/#!/s/"
  ["video:twitch"]="https://www.twitch.tv/search?term="
  ["video:rumble"]="https://rumble.com/search/all?q="
  ["video:odysee"]="https://odysee.com/$/search?q="

  ["video:imdb"]="http://www.imdb.com/find?ref_=nv_sr_fn&q="
  ["video:rottentomatoes"]="https://www.rottentomatoes.com/search/?search="

  ["misc:google.maps"]="https://www.google.com/maps?q="
  ["misc:vimawesome"]="http://vimawesome.com/?q="
  ["misc:alternativeto"]="https://alternativeto.net/browse/search?q="
  ["misc:piratebay"]="https://thepiratebay.org/search/"
  ["misc:symbolhound"]="http://symbolhound.com/?q="
  ["misc:goodreads"]="https://www.goodreads.com/search?q="

  ["misc:wikipedia"]="https://www.wikipedia.org/w/index.php?title=Special:Search&search="
  ["misc:reddit"]="https://www.reddit.com/search/?q="
  ["misc:wolframalpha"]="https://www.wolframalpha.com/input?i="
  ["misc:archive"]="https://archive.org/search?query="

)

# List for rofi
gen_list() {
    for i in "${!URLS[@]}"
    do
      echo "$i"
    done
}

main() {
  # Pass the list to rofi
  platform=$( (gen_list) | rofi -dmenu -matching fuzzy -no-custom -location 0 -p "Search > " )

  if [[ -n "$platform" ]]; then
    query=$( (echo ) | rofi  -dmenu -matching fuzzy -location 0 -p "Query > " )

    if [[ -n "$query" ]]; then
      url=${URLS[$platform]}$query
      xdg-open "$url"
    else
      exit
    fi

  else
    exit
  fi
}

main

exit 0
