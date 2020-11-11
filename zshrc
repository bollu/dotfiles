# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt incappendhistory #Immediately append to the history file, not just when a term is killed

alias ls='ls --color=auto'
alias grep='grep --color=auto'

bindkey '^x^e' edit-command-line


autoload -Uz compinit promptinit
autoload -U edit-command-line
zle -N edit-command-line

compinit
promptinit
prompt suse

# This will set the default prompt to the walters theme
zstyle ':completion:*' menu select


##!   # User configuration
##!   
##!   # export MANPATH="/usr/local/man:$MANPATH"
##!   
##!   # You may need to manually set your language environment
##!   # export LANG=en_US.UTF-8
##!   
##!   export EDITOR=vim
##!   # Preferred editor for local and remote sessions
##!   # if [[ -n $SSH_CONNECTION ]]; then
##!   #   export EDITOR='vim'
##!   # else
##!   #   export EDITOR='mvim'
##!   # fi
##!   
##!   # Compilation flags
##!   # export ARCHFLAGS="-arch x86_64"
##!   
##!   # ssh
##!   # export SSH_KEY_PATH="~/.ssh/rsa_id"
##!   
##!   # Set personal aliases, overriding those provided by oh-my-zsh libs,
##!   # plugins, and themes. Aliases can be placed here, though oh-my-zsh
##!   # users are encouraged to define aliases within the ZSH_CUSTOM folder.
##!   # For a full list of active aliases, run `alias`.
##!   #
##!   # Example aliases
##!   # alias zshconfig="mate ~/.zshrc"
##!   # alias ohmyzsh="mate ~/.oh-my-zsh"
##!   export PATH=/home/bollu/build/ninja:$PATH
##!   export PATH=$HOME/.cabal/bin:$PATH
##!   
##!   
##!   # VTune configuration
##!   source /opt/intel/vtune_amplifier/amplxe-vars.sh 
##!   
##!   iiitproxy() {
##!       export HTTP_PROXY=http://proxy.iiit.ac.in:8080
##!       export HTTPS_PROXY=http://proxy.iiit.ac.in:8080
##!       export http_proxy=http://proxy.iiit.ac.in:8080
##!       export https_proxy=http://proxy.iiit.ac.in:8080
##!   }
##!   
##!   noproxy() {
##!       unset HTTP_PROXY
##!       unset HTTPS_PROXY
##!       unset http_proxy
##!       unset https_proxy
##!   }
##!   
##!   
##!   
##!   
##!   transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
##!       tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; } 
##!   alias vim=nvim
##!   
##!   alias po=/home/bollu/build/llvm/build/bin/opt 
##!   alias polit=/home/bollu/build/llvm/build/bin/llvm-lit
##!   alias po-lit=/home/bollu/build/llvm/build/bin/llvm-lit
##!   
##!   
##!   # NVVP
##!   export PATH=/usr/local/cuda-9.1/bin${PATH:+:${PATH}}
##!   export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
##!   export LD_LIBRARY_PATH=/usr/local/cuda-9.1/lib64:${LD_LIBRARY_PATH}
##!   export LD_LIBRARY_PATH=$HOME/.local/lib/:$LD_LIBRARY_PATH
##!   # Matlab
##!   export PATH=/home/bollu/software/R2017a/bin:$PATH
##!   #Arc
##!   export PATH=$PATH:/home/bollu/software/arcanist/arcanist/bin
##!   # Blender
##!   export PATH=/home/bollu/software/blender/blender-2.79b-linux-glibc219-x86_64:$PATH
##!   # GHC
##!   export PATH=/opt/ghc/bin:$PATH
##!   # bluespec
##!   export BLUESPEC_HOME=/home/bollu/software/bluespec/bluespec
##!   export BLUESPECDIR=$BLUESPEC_HOME/lib
##!   export LM_LICENSE_FILE=27000@10.4.21.49
##!   export PATH=$PATH:${BLUESPEC_HOME}/bin:${BLUESPEC_HOME}/util/flexlm/x86_64_re3
##!   # XILINX
##!   export LM_LICENSE_FILE=$LM_LICENSE_FILE:"2100@10.4.21.95"
##!   export XILINXD_LICENSE_FILE="2100@10.4.21.95"
##!   #hub
##!   export PATH=$PATH:/home/bollu/software/hub/bin
##!   # ISPC
##!   export PATH=$PATH:/home/bollu/software/ispc-v1.9.2-linux/
##!   #VIVADO
##!   export PATH=$PATH:/home/bollu/software/xilinx/Vivado/2017.4/bin
##!   
##!   # SAGE
##!   export PATH=$PATH:$HOME/software/SageMath/
##!   
##!   export PATH=$HOME/software:$PATH
##!   export PATH=$HOME/software/amplide.linux64/:$PATH
##!   [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
##!   export PATH=$HOME/.fzf/bin:$PATH
##!   export PATH=$HOME/.dotnet/tools:$PATH
##!   export PATH=/home/bollu/software/clion-2019.2.5/bin:$PATH
##!   
##!   alias hotspot='nmcli d wifi hotspot ifname wlp3s0 ssid bollu-hotspot password 123123123'
##!   
##!   # can't do this for everything
##!   export GDK_SCALE=1
##!   alias speak='espeak -v en-us "$(xclip -o)"'
##!   
##!   alias vim=nvim
##!   
##!   
##!   export PATH=/home/bollu/software/gap-4.11.0:$PATH
##!   export PATH=/home/bollu/.local/cmake-3.17.3-Linux-x86_64/bin:$PATH
##!    
##!   # run urgent
##!   # cat ~/urgent.md
##!   # alias urgent="cat ~/urgent.md"
##!   
##!   export PATH=/home/bollu/software/node/node-v12.18.0-linux-x64/bin:$PATH
##!   alias screenshot='import ~/ss.png'
##!   alias ss='import ~/ss.png'
##!   
##!   alias airgap="nmcli radio wifi off"
##!   alias unairgap="nmcli radio wifi on"
##!   
##!   alias dvorak="setxkbmap -layout dvorak"
##!   alias qwerty="setxkbmap -layout us"
##!   
##!   # gurobi
##!   export PATH=/home/bollu/software/gurobi902/linux64/bin:$PATH
##!   export LD_LIBRARY_PATH=/home/bollu/software/gurobi902/linux64/lib:$LD_LIBRARY_PATH
##!   export GUROBI_HOME=$HOME/gurobi/
##!   
##!   # MAN pth for MLIR
##!   export MANPATH=/home/bollu/work/mlir/mlir-docs/docs/man:$MANPATH
##!   
##!   alias news=newsbeuter
##!   alias reddit=newsbeuter
##!   alias hackernews=newsbeuter
##!   
##!   # Clipboard interactions
##!   alias copyfile='xclip -selection clipboard'
##!   alias pastefile='xclip -selection clipboard -o'
##!   alias xcopy='xclip -selection clipboard'
##!   alias xpaste='xclip -selection clipboard -o'
##!   
##!   export OPENSCADPATH=$OPENSCADPATH:/home/bollu/software/dotSCAD/src
##!   
##!   alias newword=$HOME/dotfiles/newword.sh
##!   alias word=$HOME/dotfiles/newword.sh
##!   
##!   echo "======="
##!   $HOME/dotfiles/newword.sh
##!   echo "======="
##!   #
##!   # OPAM configuration
##!   # . /home/bollu/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

alias -g vim=nvim
export LD_LIBRARY_PATH=$HOME/.local/lib/:$LD_LIBRARY_PATH
export PATH=/home/bollu/.local/cmake-3.17.3-Linux-x86_64/bin:$PATH
export PATH=/home/bollu/build/ninja:$PATH
export PATH=$HOME/.fzf/bin:$PATH

alias seminar="google-chrome http://web2py.iiit.ac.in/seminar/default/upcoming"
alias ss='import ~/ss.png'
alias screenshot='import ~/ss.png'
cat ~/urgent.md

$HOME/dotfiles/newword.sh 
source ~/dotfiles/ghci-core.sh
