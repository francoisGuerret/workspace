" Setting some decent VIM settings for programming

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" First of all: Vundle

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin('~/.vim/bundle')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Git in vim
Plugin 'tpope/vim-fugitive'
" NERDTree
Plugin 'scrooloose/nerdtree'
" For notes
Plugin 'https://github.com/vimwiki/vimwiki'
" ALE for linting completion and so on
Plugin 'dense-analysis/ale'

" All Plugins must be added before the following line
call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git message edition
if has("autocmd")
    "Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,git-rebase-todo setlocal fileencodings=utf-8

    "Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && expand("%") !~ "COMMIT_EDITMSG"
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff"
      \           && expand("%") !~ "git-rebase-todo" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff
      autocmd BufNewFile,BufRead *.diff set filetype=diff

      autocmd Syntax diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

      autocmd Syntax gitcommit setlocal textwidth=74
endif " has("autocmd")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
" Use parenthesis for indentation
autocmd BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp setlocal cino=(0,W2s,>0


" Basic configuration
set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets
set vb                          " turn on the "visual bell"
set ruler                       " show the cursor position all the time
set laststatus=2
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set showmode                    " show the current mode
syntax on                       " turn syntax highlighting on by default
set number
set relativenumber
set hls                         " highlight search
set mouse=a

set tabstop=2
set shiftwidth=2
set expandtab
set textwidth=80
set encoding=utf8
" Ctrl-C
set clipboard=unnamedplus
" Fold method
set foldmethod=indent
"set foldmethod=syntax
set foldlevelstart=20

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All about theme and colors
set background=dark
colorscheme desert

""""" display time date in the editor status line
set statusline=
set statusline +=%1*\ %n\ %*                        "buffer number
set statusline +=%3*%y%*                            "file type
set statusline +=%4*\ %<%F%*                        "full path
set statusline +=%2*%m%*                            "modified flag
set statusline +=%5*\ \ \ \ %{strftime('%H:%M')}%*  " print time
set statusline +=%1*%=%5l%*                         "current line
set statusline +=%2*/%L%*                           "total lines
set statusline +=%1*%4v\ %*                         "virtual column number
set statusline +=%2*0x%04B\ %*                      "character under cursor

"""""""""" Color when more than 80 characters
highlight OverLength ctermbg=red ctermfg=black guibg=#ffd7e7
nmap <C-E> :highlight OverLength ctermbg=red ctermfg=black guibg=#ffd7e7<CR>
nmap <C-Q> :highlight clear OverLength<CR>
match OverLength /\%81v.\+/
" Highlight 81 comlumn
let &colorcolumn="81"

"""""""""" Highlight traling white space
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The simplest gvim windows possible please
if has("gui_running")
  set go-=T
  set go-=m
endif
" F***ing blink screen off
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map leader (for vimwiki among others)
let mapleader=","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Avoid ESCAPE and others bad habits
imap >> ->
imap jk <Esc>
imap jh <Esc> :w<CR>
nnoremap <Left> :echo "No arrow for you!"<CR>
vnoremap <Left> :<C-u>echo "No arrow for you!"<CR>
nnoremap <Right> :echo "No arrow for you!"<CR>
vnoremap <Right> :<C-u>echo "No arrow for you!"<CR>
nnoremap <Up> :echo "No arrow for you!"<CR>
vnoremap <Up> :<C-u>echo "No arrow for you!"<CR>
nnoremap <Down> :echo "No arrow for you!"<CR>
vnoremap <Down> :<C-u>echo "No arrow for you!"<CR>

" more practical split switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" remove whitespaces
nmap dsds :execute ":%s/\\s\\+$//g"<CR>

" md/rst: add "`" around the current word (between two spaces)
imap £ <Esc>ciW``<Esc>P<Space>a
nmap £ ciW``<Esc>P<Space>a

" Zatsall
