#!/bin/zsh
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
grim -g "$(slurp)" "$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

