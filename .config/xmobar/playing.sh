#!/bin/bash

cur_play=`cmus-remote -Q | grep -e '^tag title' | cut -d ' ' -f 3-`

if [ ! -z "$cur_play" ];
then
        artist=`cmus-remote -Q | grep -e '^tag artist' | cut -d ' ' -f 3-`
        echo "Playing: $artist - $cur_play"
fi
