#!/bin/bash

# If hyprsunset is already running → kill it (turn off)
if pgrep -x "hyprsunset" >/dev/null; then
    pkill -x hyprsunset
    exit 0
fi

# Otherwise → start it (turn on)
hyprsunset --temperature 4000 --gamma 100

