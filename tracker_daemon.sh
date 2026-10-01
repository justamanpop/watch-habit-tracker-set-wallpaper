#!/bin/bash

current_cycle=1

current_year=$(date +%Y)
current_month=$(date +%m)
WATCHED_FILE="$HOME/Desktop/cycles/${current_year}${current_month}c${current_cycle}.csv"
SCRIPT_TO_RUN="$HOME/development/one_shots/watch_ods/update_background_image_tracker.sh"

while inotifywait -e close_write "$WATCHED_FILE"; do bash "$SCRIPT_TO_RUN"; done

