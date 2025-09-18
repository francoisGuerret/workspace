# workspace

This repository is used to store some useful configuration files to hasten the
installation of a decent working environment.

## Dependencies

Install the following packages with your package manager:

  * python3
  * ripgrep (for a faster grep utils)
  * teminator

For debian eg, just run:

```bash
sudo apt install git python3 ripgrep terminator
```

### Setup with vim

Install `vim-gtk` (for gvim, better clipboard management and so on).

To setup the environment, run `setup.sh`.

Then open vim, source the installed `~/.vim/vimrc` if not automatically done and
run `:PluginInstall`.

### Setup with neovim

Install `neovim`, copy `init.lua` in `${HOME}/.config/nvim/`.
Open Neovim and install/update plugins with `:Lazy`.
Open Neovim and install via `:Mason` your favorite linters and parsers.

TODO : rerun from scratch
