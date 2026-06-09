#!/bin/bash
CYCLE=1

MISSION_COUNT=$(node get_mission_counts.js $CYCLE)

./create_background_image.sh $MISSION_COUNT

BACKGROUND_CONFIG_FOLDER=/home/anishs/.config/cosmic/com.system76.CosmicBackground/v1
cp "$BACKGROUND_CONFIG_FOLDER/all.bak" "$BACKGROUND_CONFIG_FOLDER/all"; cp "$BACKGROUND_CONFIG_FOLDER/all.tracker" "$BACKGROUND_CONFIG_FOLDER/all"
