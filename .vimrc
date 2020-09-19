filetype off

let mapleader = " "

call plug#begin('~/.vim/plugged')
call plug#end()

set termguicolors
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set background=dark

filetype plugin indent on
syntax on
