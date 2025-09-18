#! /bin/bash
set -e
set -x

VIMDIR="$HOME/.vim"

if [ ! -d "$VIMDIR/bundle" ]; then
  echo "Create $VIMDIR/bundle"
  mkdir -p "$VIMDIR/bundle"
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

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git "$VIMDIR/bundle/Vundle.vim"

