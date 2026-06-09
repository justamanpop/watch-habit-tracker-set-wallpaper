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

textX=30

MISSION_COUNT=$@
echo "Mission count is $MISSION_COUNT"

#TODO: fill up squares with color based on passed in mission count

horizontalLines=()
for i in $(seq 0 $rowCount)
do
	y=$((y0+i*yIncrement))
	horizontalLines+=("-draw" "line $x0,$y $x1,$y")
done

verticalLines=()
for i in $(seq 0 $columnCount)
do
	x=$((x0+i*xIncrement))
	verticalLines+=("-draw" "line $x,$y0 $x,$y1")
done

dayNumbers=()
for i in $(seq 0 $((rowCount -1)))
do
	for j in $(seq 0 $((columnCount -1)))
	do
		x=$((x0 + i*xIncrement + 15))
		y=$((y0 + j*yIncrement + 15))
		day=$((j*6 + i + 1))
		if [ "$day" -le "$maxDays" ]; then
			dayNumbers+=("-draw" "text $x,$y '$day'")
		fi
	done
done

finalCommand=(
    magick 
    -size 550x550 
    canvas:white 
    -fill white 
    -stroke black 
    "${horizontalLines[@]}" 
    "${verticalLines[@]}" \
    "${dayNumbers[@]}" /home/anishs/Desktop/cycles/tracker.png
 # -draw "text $textX,415 'LAMO'" /home/anishs/Desktop/cycles/tracker.png
)
"${finalCommand[@]}"
