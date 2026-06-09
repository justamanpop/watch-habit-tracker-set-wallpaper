#!/bin/bash
x0=50
y0=50
x1=500
y1=425

xIncrement=75
yIncrement=75

rowCount=5
columnCount=6

textX=30

MISSION_COUNT=$@
echo "Mission count is $MISSION_COUNT"

#TODO: put date numbers inside squares, fill up squares with color based on passed in mission count


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

finalCommand=(
    magick 
    -size 550x450 
    canvas:white 
    -fill white 
    -stroke black 
    "${horizontalLines[@]}" 
    "${verticalLines[@]}" \
 -draw "text $textX,80 '1'" `#date numbers` \
 -draw "text $textX,155 '7'" \
 -draw "text $textX,230 '13'" \
 -draw "text $textX,305 '20'" \
 -draw "text $textX,385 '27'" \
 -draw "text $textX,400 'AY'" `#color fills` \
 -draw "text $textX,415 'LAMO'" test.png
)
"${finalCommand[@]}"
