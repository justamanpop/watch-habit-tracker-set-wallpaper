#!/bin/bash
rowCount=6
columnCount=6

maxDays=31

x0=50
y0=50
x1=500
y1=500

xIncrement=75
yIncrement=75

MISSION_RESULTS=("$@")

rectangles=()
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
    "${dayNumbers[@]}" 
    test.png
)


echo "${finalCommand[@]}"
"${finalCommand[@]}"
