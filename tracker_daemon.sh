#!/bin/bash

WATCHED_FILE="$HOME/Desktop/cycles/202607c1.csv"
SCRIPT_TO_RUN="$HOME/development/one_shots/watch_ods/update_background_image_tracker.sh"

while inotifywait -e close_write "$WATCHED_FILE"; do bash "$SCRIPT_TO_RUN"; done

