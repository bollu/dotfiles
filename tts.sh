#!/bin/bash
pico2wave -w=/tmp/test.wav "$@"
aplay /tmp/test.wav
rm /tmp/test.wav

