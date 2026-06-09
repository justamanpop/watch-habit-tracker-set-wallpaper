### Files
- watch_file.sh -> given a file to watch and a path to a script as arguments, runs `bash <script>` every time file is changed
- update_background_image_tracker.sh -> the script will reads the ODS file, draw the tracker calendar image accordingly, then update config so desktop background is reset to udpated image
- create_background_image.sh -> creates the background image png file with calendar grid

### Command to start watch
./watch_file.sh "$HOME/development/one_shots/watch_ods/test.txt /home/anishs/development/one_shots/watch_ods/update_background_image_tracker.sh"
