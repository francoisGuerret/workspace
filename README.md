# workspace

This repository is used to store some useful configuration files to hasten the
installation of a decent working environment.

## Setup

To setup the environment, run `setup.sh` and install the following packages
with your package manager (if they are available of course):

  * python3
  * ripgrep (for a faster grep utils)
  * teminator
  * vim

Then open vim, source the installed `~/.vim/vimrc`if not automatically done and
run `:PluginInstall`.
