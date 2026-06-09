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

MISSION_COUNT=$@
echo "Mission count is $MISSION_COUNT"

#TODO: fill up squares with color based on passed in mission count, add heading with month year to top of img


rectangles=()
dayNumbers=()
for row in $(seq 0 $((rowCount -1)))
do
	for col in $(seq 0 $((columnCount -1)))
	do
		rectX0=$((x0 + row*xIncrement))
		rectY0=$((y0 + col*yIncrement))
		rectX1=$((rectX0 + xIncrement))
		rectY1=$((rectY0 + yIncrement))
		rectangles+=("-draw" "rectangle $rectX0,$rectY0 $rectX1,$rectY1")

		numX=$((x0 + row*xIncrement + 15))
		numY=$((y0 + col*yIncrement + 15))
		day=$((col*6 + row + 1))
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
