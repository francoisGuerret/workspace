plugins=(
  git
  vi-mode
)

# setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
fpath=($fpath ${HOME}/.zsh/completions)

autoload -Uz compinit
compinit

compdef _appmf "appmf_main.py"

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate _ignored _files
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu yes select
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' use-compctl false

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


function mkcd {
  mkdir ${1} && cd ${1}
}

function v {
  gvim -O $@ &
}

function nv {
  nvim -O $@
}

function venv {
  source "${HOME}/code/$@/.venv/bin/activate"
}

function vf {
  gvim -O $(find . -name $1) &
}
function gld {
  git log --oneline --graph --decorate `git rev-parse --abbrev-ref HEAD` ${1} `git merge-base $(git rev-parse --abbrev-ref HEAD) ${1}`^!
}
function killbd {
  c=0
  while [ "$(pidof bdsrvscand.bin > /dev/null; echo $?)" -eq "0" ]
    do
      pidof bdsrvscand.bin | xargs sudo kill -9
      let "++c"
      sleep 1
    done

  while [ "$(pidof bdsecd > /dev/null; echo $?)" -eq "0" ]
    do
      pidof bdsecd | xargs sudo kill -9
      let "++c"
      sleep 1
    done

  echo "$c BitDefender scan processes killed, stopping Bit Defender"
  sudo /opt/bitdefender-security-tools/bin/bd stop
}

# For the stupid man I am
alias cp="cp -i"
alias mv="mv -i"

alias f="find . -name"
alias g="git"
alias ll="ls -lA"
alias l="ls --color"

# find last edited files in directory
alias lfe='find $1 -type f -exec stat --format '%Y :%y %n' "{}" \; | sort -nr | cut -d: -f2- | head'

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
autoload -U colors && colors
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b %a[%m%u%c]'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%{$fg[red]%}%* %{$reset_color%}%{$fg[blue]%}${PWD/#$HOME/~}%{$reset_color%} %{$fg[yellow]%}${vcs_info_msg_0_} %{$reset_color%} %% '

export EDITOR=vim
export VISUAL=vim
export KEYTIMEOUT=1
bindkey -v
bindkey "^R" history-incremental-search-backward
