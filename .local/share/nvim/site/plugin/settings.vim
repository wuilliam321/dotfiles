set nocompatible
set rtp+=~/go/bin/fzf
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
set noshowmode
set cmdheight=2
set updatetime=50
set shortmess+=c
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set cursorline
set clipboard=unnamedplus
set inccommand=nosplit
set signcolumn="yes"
set colorcolumn=80
set spelllang=en
set completeopt=menuone,noinsert,noselect
set omnifunc=v:lua.vim.lsp.omnifunc

set list
set listchars=nbsp:⦸
set listchars+=tab:▷-
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set nojoinspaces

let g:language_client_log_level = 'debug'
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:completion_sorting = "length"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:diagnostic_show_sign = 1
let g:diagnostic_insert_delay = 1
let g:diagnostic_enable_virtual_text = 1
