" Setting some decent VIM settings for programming

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" First of all: Vundle

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin('~/.vim/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" git in vim
Plugin 'tpope/vim-fugitive'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" fast html edition
Plugin 'rstacruz/sparkup', {'rtp': 'vim'}
" Syntactic
" Plugin 'scrooloose/syntastic'
Plugin 'valloric/youcompleteme'
" NERDTree
Plugin 'scrooloose/nerdtree'
"taglist
Plugin 'taglist.vim'
" CTRLP
Plugin 'ctrlpvim/ctrlp.vim'
" All possible colorschemes
Plugin 'flazz/vim-colorschemes'
" Tabular
Plugin 'godlygeek/tabular'
" Markdown support
Plugin 'plasticboy/vim-markdown'
" Vimwiki
Plugin 'https://github.com/vimwiki/vimwiki'
" Generation of Doxygen comments :Dox
Plugin 'DoxygenToolkit.vim'
" Colors in doxygen comments
Plugin 'DoxyGen-Syntax'
" Full screen for windows
"Plugin 'kkoenig/wimproved.vim'
" ack in vim
Plugin 'ack.vim'
" For Bison and flex
Plugin 'justinmk/vim-syntax-extra'
" No distraction mode
Plugin 'junegunn/goyo.vim'
" Fixed solarized theme
Plugin 'icymind/NeoSolarized'
" A nice theme more
Plugin 'morhetz/gruvbox'
" To learn to write english
Plugin 'reedes/vim-wordy'

" All of your Plugins must be added before the following line
call vundle#end()            " required

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
" flex
autocmd BufRead,BufNewFile *.ll,*.fl,*.flex,*.l,*.lm setlocal ft=lex
" bison
autocmd BufRead,BufNewFile *.yy,*.y,*.ypp,*.ym setlocal ft=yacc
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
" to see the current line
"set cursorline
" to see the current column 
"set cursorcolumn
" Activate spell
set spell

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All about theme and colors

" set ligth theme
function! Light()
  set background=light
  colorscheme NeoSolarized
endfunction

" set dark theme
function! Dark()
  set background=dark
  colorscheme gruvbox
endfunction

" A cursor I can see
function! MyCursor()
  highlight Cursor guifg=white guibg=steelblue
  highlight iCursor guifg=red guibg=red
  set guicursor=n-v-c:block-Cursor
  set guicursor+=i:ver20-iCursor
endfunction

" Status Bar color
function! MyStatusLine()
  hi User1 guifg=#eea040 guibg=#222222
  hi User2 guifg=#dd3333 guibg=#222222
  hi User3 guifg=#ff66ff guibg=#222222
  hi User4 guifg=#a0ee40 guibg=#222222
  hi User5 guifg=#eeee40 guibg=#222222
endfunction

" Light theme if sunny hour
let s:time = strftime("%H")
let s:islight = (s:time > 11 && s:time < 17 ? 1 : 0)

" Entry point to set the colorscheme
function! SetBackground()
  if s:islight
    call Light()
  else
    call Dark()
  endif
  call MyCursor()
  call MyStatusLine()
  " Fonts
  " set guifont=Free\ Mono\ Regular\ 10
endfunction

" At start
" eovim do not set gui_running yet
"if has('gui_running')
call SetBackground()
" endif

" To toggle colorscheme
function! ToggleBackground()
  let s:islight = (s:islight ? 0 : 1)
  call SetBackground()
endfunction*

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" CTRL-P
set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle
set runtimepath^=~/.vim
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|doc|build)$',
  \ 'file': '\v\.(exe|so|dll|obj|sbr|o|pyc)$',
  \ }

" The simplest gvim windows possible please
if has("gui_running")
  set go-=T
  set go-=m
endif
" F***ing blink screen off
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" You complete me
let g:ycm_register_as_syntastic_checker = 1
let g:Show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_open_loclist_on_ycm_diags = 1


let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_path_to_python_interpreter = '/usr/bin/python3.6'
let g:ycm_server_python_interpreter = '/usr/bin/python3.6'


let g:ycm_server_use_vim_stdout = 0 " logging to console
let g:ycm_server_log_level = 'info'


" let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" let g:ycm_confirm_extra_conf = 1


let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_key_invoke_completion = '<C-Space>'

" Doxygen syntax
let g:load_doxygen_syntax = 1
let g:doxygen_enhanced_colour = 0

" Doxygen toolkit
let g:DoxygenToolkit_briefTag_pre         = "\\brief TODO"
let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "
let g:DoxygenToolkit_paramTag_pre         = "\\param "
let g:DoxygenToolkit_returnTag            = "\\return "
let g:DoxygenToolkit_throwTag_pre         = "\\throw "
let g:DoxygenToolkit_fileTag              = "\\file "
let g:DoxygenToolkit_authorTag            = "\\author "
let g:DoxygenToolkit_dateTag              = "\\date "
let g:DoxygenToolkit_versionTag           = "//version "
let g:DoxygenToolkit_blockTag             = "\\name "
let g:DoxygenToolkit_classTag             = "\\class "
let g:DoxygenToolkit_startCommentTag      = "/*! "
let g:DoxygenToolkit_startCommentBlock    = "/* "
let g:DoxygenToolkit_compactDoc           = "yes"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map leader
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

" others remappings

nmap <C-s> :silent! execute ":%s/\\s\\+$//g"<CR> :w<CR>
imap <C-s> <Esc>:silent! execute ":%s/\\s\\+$//g"<CR> :w<CR>
" remove whitespaces
nmap <F1> :execute ":%s/\\s\\+$//g"<CR>
" windows path to normal path
nmap <F3> :s/\\/\//g<CR> :s/X:/\/x/g<CR>
" switch colorschem light/dark
nmap <F4> :call ToggleBackground()<CR>
" YCM
nmap <F10> :YcmForceCompileAndDiagnostics<CR>
" switch diffof diffon
nmap <A-d>  :if &diff<CR>diffoff<CR>set nocrb<CR>else<CR>diffthis<CR>endif<CR><CR>

" Zatsall
