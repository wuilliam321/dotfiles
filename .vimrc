filetype off

let mapleader = " "

call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'gruvbox-community/gruvbox'
call plug#end()

highlight ColorColumn ctermbg=0 guibg=lightgrey

set termguicolors
let g:gruvbox_contrast_dark="hard"
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
let g:gruvbox_italic = 1
let g:gruvbox_termcolors=16

colorscheme gruvbox
set background=dark

filetype plugin indent on
syntax on

lua package.loaded["mylspconfig"] = nil
lua require("mylspconfig")
