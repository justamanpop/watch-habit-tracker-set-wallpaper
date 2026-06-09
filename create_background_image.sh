#!/bin/bash
x0=50
y0=50
x1=500
y1=500

xIncrement=75
yIncrement=75

rowCount=6
columnCount=6
maxDays=31

MISSION_RESULTS=("$@")
echo "${MISSION_RESULTS[@]}"
get_color_of_result() {
  case "$1" in
    0)  echo "white" ;;
    1)  echo "yellow" ;;
    2)  echo "green" ;;
    -1) echo "red" ;;
    *)  echo "white" ;;
  esac
}
#TODO: fill up squares with color based on passed in mission count, add heading with month year to top of img, make node script consider cycle number passed in


rectangles=()
dayNumbers=()
for row in $(seq 0 $((rowCount -1)))
do
	for col in $(seq 0 $((columnCount -1)))
	do
		day=$((col*6 + row + 1))

		rectX0=$((x0 + row*xIncrement))
		rectY0=$((y0 + col*yIncrement))
		rectX1=$((rectX0 + xIncrement))
		rectY1=$((rectY0 + yIncrement))
		dayResult="${MISSION_RESULTS[$((day - 1))]}"

		color=$(get_color_of_result $dayResult)

		rectangles+=("-fill" "$color" "-draw" "rectangle $rectX0,$rectY0 $rectX1,$rectY1")

		numX=$((x0 + row*xIncrement + 15))
		numY=$((y0 + col*yIncrement + 15))
		if [ "$day" -le "$maxDays" ]; then
			dayNumbers+=("-draw" "text $numX,$numY '$day'")
		fi
	done
done


finalCommand=(
    magick 
    -size 550x550 
    canvas:white 
    -fill white 
    -stroke black 
    "${rectangles[@]}" 
    "${dayNumbers[@]}" /home/anishs/Desktop/cycles/tracker.png
)
"${finalCommand[@]}"
