#!/usr/bin/env python
import sys
if __name__ == "__main__":
    inp = sys.argv[1]
    if inp[0] == "+":
        delta = 1
    elif inp[0] == "-":
        delta = -1
    else:
        raise RuntimeError ("unknown, please use format: {+,-}<number>")

    val = int(inp[1:]) * delta

    with open("/sys/class/backlight/intel_backlight/brightness", "r") as f:
        curval = int("".join(f.readlines()))

    print (val, type(val))
    print (curval, type(curval))

    with open("/sys/class/backlight/intel_backlight/brightness", "w") as f:
        f.write(str(val + curval))



