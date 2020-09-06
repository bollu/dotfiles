#!/usr/bin/env bash
shuf -n 1 $HOME/dotfiles/dict.csv | sed -e 's/\(.*\),\(.*\)/\1: \2/g'
