# sudo brightnessctl s 3%
set PATH /home/bollu/work/mlir/lz/build/bin $PATH
set PATH /home/bollu/work/mlir/lz $PATH # for run-optimised.sh
set PATH /home/bollu/.local/cmake-3.17.3-Linux-x86_64/bin $PATH
set PATH /home/bollu/build/ninja $PATH
set PATH /home/bollu/.fzf/bin $PATH
set PATH /home/bollu/work/mlir/llvm-project/build/bin $PATH
set PATH /home/bollu/.local/go/bin $PATH
set PATH /home/bollu/go/bin $PATH

# LLVM paths
set PATH /home/bollu/work/mlir/llvm-project/build/bin/ $PATH
set LD_LIBRARY_PATH /home/bollu/work/mlir/llvm-project/build/lib $LD_LIBRARY_PATH
set C_INCLUDE_PATH /home/bollu/work/mlir/llvm-project/build/include/ $C_INCLUDE_PATH

alias vim=nvim
alias ss='import ~/ss.png'
alias screenshot='import ~/ss.png'

fish_vi_key_bindings

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

function fish_prompt
        echo (pwd) '> '
end

function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
end

cat /home/bollu/o1.md

alias airgap="nmcli radio wifi off"
alias unairgap="nmcli radio wifi on"
alias pwncollege="ssh cse466@cse466.pwn.college"
