#!/bin/bash

while inotifywait -e close_write "$1"; do bash "$2"; done
