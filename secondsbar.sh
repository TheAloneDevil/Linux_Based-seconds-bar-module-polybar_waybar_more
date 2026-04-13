#!/bin/bash
SPACECHAR=$'\xE2\x80\x83'
seconds=$((10#$(date +%S)))
minutes=$((10#$(date +%M)))

# At second 0, show all 12 bars for 1 second, otherwise calculate normally
if [ $seconds -eq 0 ]; then
    filled=12
else
    filled=$((seconds / 5))
fi

empty=$((12 - filled))

colors=("#00ff00" "#00dd00" "#22bb00" "#44aa00" "#668800" "#8b6914" "#aa6600" "#cc5500" "#dd4400" "#ee3300" "#ff2200" "#ff1100")

bar=""
for i in $(seq 1 $filled); do
    idx=$((i - 1))
    color=${colors[$idx]}
    bar+="%{T22}%{F$color}▐%{F-}%{T-}"
done

for i in $(seq 1 $empty); do
    bar+="%{T22}%{F#444444}▐%{F-}%{T-}"
done

# 12 icons for 12 x 5-minute intervals (matches clock positions)
icons=("󱑖" "󱑋" "󱑌" "󱑍" "󱑎" "󱑏" "󱑐" "󱑑" "󱑒" "󱑓" "󱑔" "󱑕")

# Use minutes to determine icon (0-4 min = icon 0, 5-9 min = icon 1, etc.)
idx=$((minutes / 5))
icon="%{F#ff7043}%{T21}${icons[$idx]}%{F-}%{T-}"

echo "$icon$SPACECHAR$bar"
