#!/bin/bash
CYCLE=1
CYCLE_CSVS_FOLDER="$HOME/Desktop/cycles"
MISSION_COUNT=$($HOME/.nvm/versions/node/v22.16.0/bin/node "$HOME/development/one_shots/watch_ods/get_mission_counts.js" $CYCLE_CSVS_FOLDER $CYCLE)

PREVIOUS_MONTH_MISSION_COUNT=$($HOME/.nvm/versions/node/v22.16.0/bin/node "$HOME/development/one_shots/watch_ods/get_previous_month_mission_counts.js" $CYCLE_CSVS_FOLDER $CYCLE)
read -r SUCCESSFUL_DAYS HALF_DAYS FAIL_DAYS TOTAL_DAYS <<< "$PREVIOUS_MONTH_MISSION_COUNT"

"$HOME/development/one_shots/watch_ods/create_background_image.sh" $SUCCESSFUL_DAYS $HALF_DAYS $FAIL_DAYS $TOTAL_DAYS $MISSION_COUNT

BACKGROUND_CONFIG_FOLDER="$HOME/.config/cosmic/com.system76.CosmicBackground/v1"
cp "$BACKGROUND_CONFIG_FOLDER/all.bak" "$BACKGROUND_CONFIG_FOLDER/all"; cp "$BACKGROUND_CONFIG_FOLDER/all.tracker" "$BACKGROUND_CONFIG_FOLDER/all"
