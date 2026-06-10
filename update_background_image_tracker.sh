#!/bin/bash
CYCLE=1
MISSION_COUNT=$($HOME/.nvm/versions/node/v22.16.0/bin/node "$HOME/development/one_shots/watch_ods/get_mission_counts.js" $CYCLE)

"$HOME/development/one_shots/watch_ods/create_background_image.sh" $MISSION_COUNT

BACKGROUND_CONFIG_FOLDER="$HOME/.config/cosmic/com.system76.CosmicBackground/v1"
cp "$BACKGROUND_CONFIG_FOLDER/all.bak" "$BACKGROUND_CONFIG_FOLDER/all"; cp "$BACKGROUND_CONFIG_FOLDER/all.tracker" "$BACKGROUND_CONFIG_FOLDER/all"
