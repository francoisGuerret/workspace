export EDITOR=eovim
export VISUAL=vim

function mkcd {
	mkdir ${1} && cd ${1}
}

function gv {
	eovim -O "$@" &
}

function gvf {
	eovim -O $(find . -name "$1") &
}

alias f="find . -name"
alias gr="grep -r -n"
alias g="git"
alias ll="ls -lA"
alias l="ls --color"
alias c.="cd .."
alias c..="cd ../.."
alias c...="cd ../../.."
alias c....="cd ../../../.."
alias c.....="cd ../../../../.."

#########################
# PS1
#########################
bash_prompt()
{
 local NONE="\[\033[0m\]"    # unsets color to term's fg color

 # regular colors
 local K="\[\033[0;30m\]"    # black
 local R="\[\033[0;31m\]"    # red
 local G="\[\033[0;32m\]"    # green
 local Y="\[\033[0;33m\]"    # yellow
 local B="\[\033[0;34m\]"    # blue
 local M="\[\033[0;35m\]"    # magenta
 local C="\[\033[0;36m\]"    # cyan
 local W="\[\033[0;37m\]"    # white

 # emphasized (bolded) colors
 local EMK="\[\033[1;30m\]"
 local EMR="\[\033[1;31m\]"
 local EMG="\[\033[1;32m\]"
 local EMY="\[\033[1;33m\]"
 local EMB="\[\033[1;34m\]"
 local EMM="\[\033[1;35m\]"
 local EMC="\[\033[1;36m\]"
 local EMW="\[\033[1;37m\]"

 PS1=$EMR'\u'$NONE': '$EMG'\w '$C'\$\n'$NONE
}
bash_prompt

# mypy path

#################
# Vi mode
set -o vi
