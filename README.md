### Overview
Script to watch a CSV file containing status of tasks for each day of the month, and on any change, generate calendar grid for the month it represents, fill in color of each day
based on completion status of tasks on that day, and make that the background of the OS (pop os 24, cosmic)

### Files
- watch_file.sh -> given a file to watch and a path to a script as arguments, runs `bash <script>` every time file is changed
- update_background_image_tracker.sh -> the script will reads the ODS file, draw the tracker calendar image accordingly, then update config so desktop background is reset to udpated image
- create_background_image.sh -> creates the background image png file with calendar grid
- get_mission_counts.js -> reads the mission cycle CSV file and returns status of each day of the month
- tracker_daemon.sh -> runs watch_file.sh, watching the cycle CSV file and running update_background_image.sh on change

### Running it as daemon automatically on boot
`mkdir -p ~/.config/systemd/user/`
`touch ~/.config/systemd/user/mission_tracker.service`

Put the following in mission_tracker.service:
```
[Unit]
Description=Cycles CSV Tracker Daemon
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash %h/development/one_shots/watch_ods/tracker_daemon.sh
Restart=on-failure
RestartSec=5

[Install]
WantedBy=default.target
```

`systemctl --user enable mission_tracker.service`

