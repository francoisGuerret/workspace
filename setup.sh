#! /bin/bash
set -e

VIMDIR="$HOME/.vim"

if [ ! -d "$VIMDIR" ]; then
  echo "Create $VIMDIR"
  mkdir $VIMDIR
fi

function install
{
  local src=$1
  local target=$2
  if [ -f $target ]; then
    echo "Confirm $target overwrite (y/N) ?"
    read -r confirm
  else
    local confirm="y"
  fi

  if [[ $confirm == "y" ]] || [[ $confirm == "Y" ]] ; then
    echo "Installing $src -> $target"
    cp $src $target
  fi
}

install vimrc $VIMDIR/vimrc
install .bashrc $HOME/.bashrc
install .gitconfig $HOME/.gitconfig

