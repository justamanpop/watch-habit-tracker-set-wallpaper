#!/bin/bash
./create_background_image.sh
BACKGROUND_CONFIG_FOLDER=/home/anishs/.config/cosmic/com.system76.CosmicBackground/v1
cp "$BACKGROUND_CONFIG_FOLDER/all.bak" "$BACKGROUND_CONFIG_FOLDER/all"; cp "$BACKGROUND_CONFIG_FOLDER/all.tracker" "$BACKGROUND_CONFIG_FOLDER/all"
