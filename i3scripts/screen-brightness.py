#!/usr/bin/env python

import sys

def print_usage(argv):
    print ("%s [+DELTA] [-DELTA]" % argv[0])

if __name__ == "__main__":
    try:
        param = sys.argv[1]
    except IndexError as e:
        print ("exception:")
        print(e)
        print_usage(sys.argv)

    with open("/sys/class/backlight/intel_backlight/brightness") as f:
        val = int(f.read().strip())

    delta = int(param[1:])
    if param[0] == "+":
        val += delta
    elif param[0] == "-":
        val -= delta
    else:
        print ("ERROR: do not understand option: %s" % (param,))
        print_usage(sys.argv)
        sys.exit(1)


    with open("/sys/class/backlight/intel_backlight/brightness", "w") as f:
        f.write(str(val))


