#!/bin/bash
x0=50
y0=50
x1=500
y1=500

xIncrement=75
yIncrement=75

rowCount=6
columnCount=6

PREVIOUS_MONTH_SUCCESS_DAYS=$1
PREVIOUS_MONTH_HALF_DAYS=$2
PREVIOUS_MONTH_FAIL_DAYS=$3
PREVIOUS_MONTH_TOTAL_DAYS=$4

LIFETIME_SUCCESS_DAYS=$5
LIFETIME_HALF_DAYS=$6
LIFETIME_FAIL_DAYS=$7
LIFETIME_TOTAL_DAYS=$8

echo "1 $PREVIOUS_MONTH_SUCCESS_DAYS"
echo "2 $PREVIOUS_MONTH_HALF_DAYS"
echo "3 $PREVIOUS_MONTH_FAIL_DAYS"
echo "4 $PREVIOUS_MONTH_TOTAL_DAYS"

echo "5 $LIFETIME_SUCCESS_DAYS"
echo "6 $LIFETIME_HALF_DAYS"
echo "7 $LIFETIME_FAIL_DAYS"
echo "8 $LIFETIME_TOTAL_DAYS"

shift 8

MISSION_RESULTS=("$@")


get_color_of_result() {
  case "$1" in
    0)  echo "white" ;;
    1)  echo "yellow" ;;
    2)  echo "green" ;;
    -1) echo "red" ;;
    *)  echo "white" ;;
  esac
}

rectangles=()
dayNumbers=()
for col in $(seq 0 $((columnCount -1)))
do
	for row in $(seq 0 $((rowCount -1)))
	do
		day=$((col*6 + row + 1))
		if [ "$day" -le "${#MISSION_RESULTS[@]}" ]; then
			rectX0=$((x0 + row*xIncrement))
			rectY0=$((y0 + col*yIncrement))
			rectX1=$((rectX0 + xIncrement))
			rectY1=$((rectY0 + yIncrement))

			dayResult="${MISSION_RESULTS[$((day - 1))]}"
			color=$(get_color_of_result $dayResult)

			rectangles+=("-fill" "$color" "-draw" "rectangle $rectX0,$rectY0 $rectX1,$rectY1")

			numX=$((x0 + row*xIncrement + 15))
			numY=$((y0 + col*yIncrement + 15))
			dayNumbers+=("-draw" "text $numX,$numY '$day'")
		fi
	done
done

heading=`date +"%B %Y"`
echo "sucess days are $PREVIOUS_MONTH_SUCCESS_DAYS half are $PREVIOUS_MONTH_HALF_DAYS fails are $PREVIOUS_MONTH_FAIL_DAYS" > /home/anishs/prev.txt

finalCommand=(
    magick 
    -size 550x550 
    canvas:white 
    -fill white 
    -stroke black 
    -draw "text $((y1/2)),$((x0 - 15)) '$heading'"
    "${rectangles[@]}" 
    "${dayNumbers[@]}" 
    -draw "text $((y0)),$((x1 + 22)) 'Previous month:\n Success: $PREVIOUS_MONTH_SUCCESS_DAYS   Half: $PREVIOUS_MONTH_HALF_DAYS   Failure: $PREVIOUS_MONTH_FAIL_DAYS'"
    -draw "text $((y1/2)),$((x1 + 22)) 'Lifetime stats:\n Success: $LIFETIME_SUCCESS_DAYS   Half: $LIFETIME_HALF_DAYS   Failure: $LIFETIME_FAIL_DAYS'" /home/anishs/Desktop/cycles/tracker.png
)
"${finalCommand[@]}"
