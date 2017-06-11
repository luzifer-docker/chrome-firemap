#!/bin/bash -ex

DPI=150
W=1754 # 150 x 11.69
H=1241 # 150 x  8.27

ZOOM=$1
LAT=$2
LON=$3
TARGET="$4"

google-chrome-stable --version
google-chrome-stable --headless --no-sandbox \
  --hide-scrollbars --disable-gpu --screenshot \
  --window-size=$W,$H --virtual-time-budget=5000 \
  "http://openfiremap.org/?zoom=${ZOOM}&lat=${LAT}&lon=${LON}&layers=B0000TF"

ls -lh
mv screenshot.png /data/${TARGET}.png
chmod 0644 /data/${TARGET}.png

exec convert /data/${TARGET}.png -compress jpeg -quality 90 \
  -resize ${W}x${H} -gravity center -extent ${W}x${H} \
  -units PixelsPerInch -density ${DPI} \
  -repage ${W}x${H} /data/${TARGET}.pdf
