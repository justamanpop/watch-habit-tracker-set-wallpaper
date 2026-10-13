#!/bin/bash
CYCLE=1
CYCLE_CSVS_FOLDER="$HOME/Desktop/cycles"
MISSION_COUNT=$($HOME/.nvm/versions/node/v22.16.0/bin/node "$HOME/development/one_shots/watch_ods/get_mission_counts.js" $CYCLE_CSVS_FOLDER $CYCLE)

PREVIOUS_MONTH_MISSION_COUNT=$($HOME/.nvm/versions/node/v22.16.0/bin/node "$HOME/development/one_shots/watch_ods/get_previous_month_mission_counts.js" $CYCLE_CSVS_FOLDER $CYCLE)
read -r PREV_MONTH_SUCCESSFUL_DAYS PREV_MONTH_HALF_DAYS PREV_MONTH_FAIL_DAYS PREV_MONTH_TOTAL_DAYS <<< "$PREVIOUS_MONTH_MISSION_COUNT"

LIFETIME_STATS=$($HOME/.nvm/versions/node/v22.16.0/bin/node "$HOME/development/one_shots/watch_ods/get_lifetime_stats.js" $CYCLE_CSVS_FOLDER $CYCLE)
read -r LIFETIME_SUCCESSFUL_DAYS LIFETIME_HALF_DAYS LIFETIME_FAIL_DAYS LIFETIME_TOTAL_DAYS <<< "$LIFETIME_STATS"

"$HOME/development/one_shots/watch_ods/create_background_image.sh" $PREV_MONTH_SUCCESSFUL_DAYS $PREV_MONTH_HALF_DAYS $PREV_MONTH_FAIL_DAYS $PREV_MONTH_TOTAL_DAYS $LIFETIME_SUCCESSFUL_DAYS $LIFETIME_HALF_DAYS $LIFETIME_FAIL_DAYS $LIFETIME_TOTAL_DAYS $MISSION_COUNT

BACKGROUND_CONFIG_FOLDER="$HOME/.config/cosmic/com.system76.CosmicBackground/v1"
cp "$BACKGROUND_CONFIG_FOLDER/all.bak" "$BACKGROUND_CONFIG_FOLDER/all"; cp "$BACKGROUND_CONFIG_FOLDER/all.tracker" "$BACKGROUND_CONFIG_FOLDER/all"
