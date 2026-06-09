#!/bin/bash
rowCount=5
columnCount=6

x0=50
y0=50
x1=500
y1=425

xIncrement=75
yIncrement=75

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
    "${verticalLines[@]}" 
    test.png
)
"${finalCommand[@]}"
