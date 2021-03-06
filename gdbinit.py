#!/usr/bin/env python3
# https://sourceware.org/gdb/current/onlinedocs/gdb/Python-API.html#Python-API
# https://interrupt.memfault.com/blog/automate-debugging-with-gdb-python-api
# https://github.com/hugsy/gef/blob/dev/gef.py
import locale
import sys
from os import path
import signal
import pygments
import pygments.formatters
import pygments.lexers
import gdb


NUM_SOURCE_CODE_LINES_TO_SHOW = 50
NUM_TTY_COLS = 80
NUM_BACKTRACE_LINES = 1000
NUM_ARG_PRINT_CHARS = 50

LEFT_ARROW = " \u2190 "
RIGHT_ARROW = " \u2192 "
DOWN_ARROW = "\u21b3"
HORIZONTAL_LINE = "\u2500"
VERTICAL_LINE = "\u2502"
CROSS = "\u2718 "
TICK = "\u2713 "

PYGMENTS_FORMATTER = pygments.formatters.Terminal256Formatter(style=str("manni"))
PYGMENTS_LEXER_CACHE = {}


# === Color library (stolen from GEF) ===
class Color:
    """Used to colorify terminal output."""
    colors = {
        "normal"         : "\033[0m",
        "gray"           : "\033[1;38;5;240m",
        "red"            : "\033[31m",
        "green"          : "\033[32m",
        "yellow"         : "\033[33m",
        "blue"           : "\033[34m",
        "pink"           : "\033[35m",
        "cyan"           : "\033[36m",
        "bold"           : "\033[1m",
        "underline"      : "\033[4m",
        "underline_off"  : "\033[24m",
        "highlight"      : "\033[3m",
        "highlight_off"  : "\033[23m",
        "blink"          : "\033[5m",
        "blink_off"      : "\033[25m",
    }

    @staticmethod
    def redify(msg):       return Color.colorify(msg, "red")
    @staticmethod
    def greenify(msg):     return Color.colorify(msg, "green")
    @staticmethod
    def blueify(msg):      return Color.colorify(msg, "blue")
    @staticmethod
    def yellowify(msg):    return Color.colorify(msg, "yellow")
    @staticmethod
    def grayify(msg):      return Color.colorify(msg, "gray")
    @staticmethod
    def pinkify(msg):      return Color.colorify(msg, "pink")
    @staticmethod
    def cyanify(msg):      return Color.colorify(msg, "cyan")
    @staticmethod
    def boldify(msg):      return Color.colorify(msg, "bold")
    @staticmethod
    def underlinify(msg):  return Color.colorify(msg, "underline")
    @staticmethod
    def highlightify(msg): return Color.colorify(msg, "highlight")
    @staticmethod
    def blinkify(msg):     return Color.colorify(msg, "blink")

    @staticmethod
    def colorify(text, attrs):
        """Color text according to the given attributes."""
        colors = Color.colors
        msg = [colors[attr] for attr in attrs.split() if attr in colors]
        msg.append(str(text))
        if colors["highlight"] in msg :   msg.append(colors["highlight_off"])
        if colors["underline"] in msg :   msg.append(colors["underline_off"])
        if colors["blink"] in msg :       msg.append(colors["blink_off"])
        msg.append(colors["normal"])
        return "".join(msg)

def print_title(msg):
    if not msg:
        print(Color.boldify(HORIZONTAL_LINE * NUM_TTY_COLS))
        return

    trail_len = len(msg) + 6
    title = ""
    title += "{:{padd}<{width}} ".format("", width=max(NUM_TTY_COLS - trail_len, 0),
                                            padd=HORIZONTAL_LINE)
    title += Color.colorify(msg, "cyan")
    title += " {:{padd}<4}".format("", padd=HORIZONTAL_LINE)
    print(title)

# === GDB SETUP ===

directory, file = path.split(__file__)
directory       = path.expanduser(directory)
directory       = path.abspath(directory)

sys.path.append(directory)

# warn if the user has different encoding than utf-8
encoding = locale.getpreferredencoding()

if encoding != 'UTF-8':
    print('******')
    print('Your encoding ({}) is different than UTF-8. pwndbg might not work properly.'.format(encoding))
    print('You might try launching gdb with:')
    print('    LC_ALL=en_US.UTF-8 PYTHONIOENCODING=UTF-8 gdb')
    print('Make sure that en_US.UTF-8 is activated in /etc/locale.gen and you called locale-gen')
    print('******')

# pwndbg.prompt.set_prompt()

pre_commands = """
set confirm off
set verbose off
set pagination off
set height 0
set history expansion on
set history save on
set follow-fork-mode child
set backtrace past-main on
set step-mode on
set print pretty on
set width 80
handle SIGALRM nostop print nopass
handle SIGBUS  stop   print nopass
handle SIGPIPE nostop print nopass
handle SIGSEGV stop   print nopass
"""

for line in pre_commands.strip().splitlines():
    gdb.execute(line)

# This may throw an exception, see pwndbg/pwndbg#27
try:
    gdb.execute("set disassembly-flavor intel")
except gdb.error:
    pass

# handle resize event to align width and completion
signal.signal(signal.SIGWINCH, lambda signum, frame: gdb.execute("set width %i" % pwndbg.ui.get_window_size()[1]))

# Workaround for gdb bug described in #321 ( https://github.com/pwndbg/pwndbg/issues/321 )
# More info: https://sourceware.org/bugzilla/show_bug.cgi?id=21946
# As stated on GDB's bugzilla that makes remote target search slower.
# After GDB gets the fix, we should disable this only for bugged GDB versions.
if 1:
    gdb.execute('set remote search-memory-packet off')

gdb.execute("set prompt %s" % "gdb$$ ")


### ===Context  ===
# from pwndbg/commands/context
def get_highlight_source(filename):
    global PYGMENTS_LEXER_CACHE

    with open(filename, encoding='utf-8') as f:
        source = f.read()
    try:
        if filename in PYGMENTS_LEXER_CACHE:
            lexer = PYGMENTS_LEXER_CACHE[filename]
        else:
            lexer = pygments.lexers.guess_lexer_for_filename(filename, source, stripnl=False)
            PYGMENTS_LEXER_CACHE[filename] = lexer
            
        source =  pygments.highlight(source, lexer, PYGMENTS_FORMATTER).rstrip()
    except pygments.util.ClassNotFound:
        pass

    source_lines = source.splitlines()
    source_lines = tuple(line.rstrip() for line in source_lines)
    return source_lines

def get_filename_and_formatted_source(nlines):
    """
    Returns formatted, lines limited and highlighted source as list
    or if it isn't there - an empty list
    """
    sal = gdb.selected_frame().find_sal()  # gdb.Symtab_and_line

    # Check if source code is available
    if sal.symtab is None:
        return '', []

    # Get the full source code
    closest_line = sal.line
    filename = sal.symtab.fullname()

    try:
        source = get_highlight_source(filename)
    except IOError:
        return '', []

    if not source:
        return '', []


    # Compute the line range
    start = max(closest_line - 1 - nlines//2, 0)
    end = min(closest_line - 1 + nlines//2 + 1, len(source))
    num_width = len(str(end))

    # split the code
    source = source[start:end]

    # Compute the prefix_sign length
    prefix_sign = ">"; prefix_width = len(prefix_sign)

    # Format the output
    formatted_source = []
    for line_number, code in enumerate(source, start=start + 1):
        fmt = ' {prefix_sign:{prefix_width}} {line_number:>{num_width}} {code}'
        # if line_number == closest_line:
        #     fmt = C.highlight(fmt)

        line = fmt.format(
            prefix_sign=prefix_sign if line_number == closest_line else '',
            prefix_width=prefix_width,
            line_number=line_number,
            num_width=num_width,
            code=code
        )
        formatted_source.append(line)

    return filename, formatted_source
        
def context_backtrace():

    this_frame    = gdb.selected_frame()
    newest_frame  = this_frame
    oldest_frame  = this_frame

    for i in range(NUM_BACKTRACE_LINES-1):
        try:
            candidate = oldest_frame.older()
        except gdb.MemoryError:
            break

        if not candidate:
            break
        oldest_frame = candidate

    for i in range(NUM_BACKTRACE_LINES-1):
        candidate = newest_frame.newer()
        if not candidate:
            break
        newest_frame = candidate

    current_frame = newest_frame
    i     = 0
    
    while current_frame:
        current_frame.select()
        if not current_frame.is_valid():
            continue
            
            
        pc = current_frame.pc()
        name = current_frame.name()
        if len(name) > 70: name = name[:17] + "..." + name[-50:]
        fn = current_frame.function()
        items = []

        CUR_FRAME_POINTER = "->"
        items.append(CUR_FRAME_POINTER if this_frame == current_frame else " " * len(CUR_FRAME_POINTER))
        items.append("[%2s]" % (i, ))

        if fn: 
            if this_frame == current_frame:
                items.append(Color.colorify("%s:%s" % (fn.symtab.filename, fn.line), "underline cyan"))
            else:
                items.append(Color.cyanify("%s:%s" % (fn.symtab.filename, fn.line)))

        
        if this_frame == current_frame:
            items.append(Color.colorify(name, "underline"))
        else: 
            items.append(name)

        items.append("{:#x}".format(pc))

        frame_args = gdb.FrameDecorator.FrameDecorator(current_frame).frame_args() or []

        print("%s" % (" ".join(items)))

        
        # args = []
        # for arg in frame_args:
        #     # argval = str(arg.sym.value(current_frame))
        #     args.append("%s %s" % (arg.sym.type, str(arg.sym)))
        #     # args.append(str(arg.sym.type))
        #     # args.append(str(arg.sym))
        # print(' '*(len(CUR_FRAME_POINTER) + 2) +  "; ".join(args))

        if current_frame == oldest_frame:
            break
        current_frame = current_frame.older()
        i    += 1

    this_frame.select()


class CtxCommand(gdb.Command):
    def __init__(self):
        super(CtxCommand, self).__init__("ctx", gdb.COMMAND_USER)

    def complete(self, text, word):
        # We expect the argument passed to be a symbol so fallback to the
        # internal tab-completion handler for symbols
        return gdb.COMPLETE_SYMBOL

    def invoke(self, args, from_tty: bool):
        args = [arg.strip() for arg in  args.strip().split(" ") if arg.strip() ]
        # print("args: %s" % args)
        if args == []:
            filename, formatted_source = get_filename_and_formatted_source(NUM_SOURCE_CODE_LINES_TO_SHOW)
            print_title("source: %s" % (filename, ))
            print("\n".join(formatted_source) if formatted_source else "<no source>")
            print_title("backtrace")
            context_backtrace()
            return

        if args[0] == "source" or args[0] == "src" or args[0] == "s":
            nlines = 20 if len(args) < 2 else int(args[1])
            filename, formatted_source = get_filename_and_formatted_source(nlines)
            print_title("source: %s" % (filename, ))
            print("\n".join(formatted_source) if formatted_source else "<no source>")
            return

        if args[0] == "backtrace" or args[0] == "bt" or args[0] == "b":
            # print specific frame
            if len(args) == 2:
                fnum = int(args[1])
                print_title("backtrace frame %s" % fnum)
                context_backtrace()

            else:
                print_title("backtrace")
                context_backtrace()


        if args[0] == "vim":
            # TODO: open file in vim
            return

        

CtxCommand()
