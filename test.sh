#!/bin/bash
x0=50
y0=50
x1=500
y1=425
textX=30

#clean up calculations later, get it working first
magick -size 550x450 canvas:white  -fill white -stroke black \
 -draw "line $x0,$y0 $x1,$y0" `# horizontal lines` \
 -draw "line $x0,125 $x1,125" \
 -draw "line $x0,200 $x1,200" \
 -draw "line $x0,275 $x1,275" \
 -draw "line $x0,350 $x1,350" \
 -draw "line $x0,$y1 $x1,$y1" \
 -draw "line $x0,$y0 $x0,$y1" `# vertical lines` \
 -draw "line 125,$y0 125,$y1" \
 -draw "line 200,$y0 200,$y1" \
 -draw "line 275,$y0 275,$y1" \
 -draw "line 350,$y0 350,$y1" \
 -draw "line 425,$y0 425,$y1" \
 -draw "line $x1,$y0 $x1,$y1" \
 -draw "text $textX,80 '1'" `#date numbers` \
 -draw "text $textX,155 '7'" \
 -draw "text $textX,230 '13'" \
 -draw "text $textX,305 '20'" \
 -draw "text $textX,385 '27'" /usr/share/backgrounds/cosmic/tracker.png 
