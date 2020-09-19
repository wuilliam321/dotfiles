filetype off

let mapleader = " "

call plug#begin('~/.vim/plugged')
    Plug 'gruvbox-community/gruvbox'
call plug#end()

let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

set nocompatible
set noshowmatch
set shell=/usr/bin/zsh
set number
set relativenumber
set hidden
set nowrap
set smartcase
set smartindent
set incsearch
set nohlsearch
set nobackup
set noswapfile
set nowritebackup
set undodir=~/.vim/undodir
set undofile
set cmdheight=2
set updatetime=50
set shortmess+=c
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set cursorline
set clipboard=unnamedplus
set signcolumn=yes
set colorcolumn=80
set completeopt=menuone,noinsert,noselect

set list
set listchars=nbsp:⦸
set listchars+=tab:▷-
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set nojoinspaces

set termguicolors
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
let g:gruvbox_contrast_dark="hard"
let g:gruvbox_italic = 1
let g:gruvbox_termcolors=16

colorscheme gruvbox
set background=dark

" theme remap
nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

filetype plugin indent on
syntax on
