#! /bin/bash
set -e
set -x

NVIMDIR="$HOME/.config/nvim"

if [ ! -d "$NVIMDIR" ]; then
  echo "Create $NVIMDIR"
  mkdir -p "$NVIMDIR"
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

install .bashrc $HOME/.bashrc
install .zshrc $HOME/.zshrc
install .gitconfig $HOME/.gitconfig

cp -rv nvim $NVIMDIR

echo "Consider opening neovim and running :Lazy"
