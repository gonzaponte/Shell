#!/usr/bin/bash

current=nothing
dump=$HOME/.clipdump

mkdir -p $dump

echo $current | xclip -i -selection clipboard

echo "starting loop"
while true;
do
    new=$(xclip -selection clipboard -o 2>&1)
    isimage=false
    
    if [[ -z $new ]]; then continue; fi

    if [[ $new = Error* ]]; then
        new=$(xclip -selection clipboard -t image/png -o | sha1sum)
        isimage=true
    fi

    if [[ $new != $current ]]; then
        timestr=$(date -Iseconds)
        timestr=${timestr// /_}
        timestr=${timestr//:/_}
        filename=$dump/$timestr
        echo pasting to $filename

        if $isimage; then
            xclip -selection clipboard -t image/png -o > $filename.png
        else
            echo $new > $filename.txt
        fi
    fi

    current=$new

    sleep 2
done
