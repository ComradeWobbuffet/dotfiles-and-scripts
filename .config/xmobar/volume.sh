#!/bin/sh

amixer get Master | awk -- '/\%/ {print ($NF ~ /off/) ? "off" : $(NF-1)}' | tr -d '\[\]' | head -n 1
