"reload vimrc
nnoremap <leader>so :source ~/.vimrc<CR>

" Open files / find files
nnoremap <leader>pp :GFiles<Cr>
nnoremap <leader>pg :PRg<Cr>
nnoremap <leader>ff :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>pa :Rg<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pw :PRg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
omap ic <Plug>(coc-classobj-i)
omap ac <Plug>(coc-classobj-a)
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)

nnoremap <silent> K                  :call <SID>show_documentation()<CR>
nnoremap <silent> <c-k>              <cmd>CocAction('showSignatureHelp')<CR>
nnoremap <silent> g0                 :<C-u>CocList outline<cr>
nnoremap <silent> gW                 :<C-u>CocList -I symbols<cr>
nmap     <silent> gd                 <Plug>(coc-definition)
nmap     <silent> gi                 <Plug>(coc-implementation)
nmap     <silent> gt                 <Plug>(coc-type-definition)
nmap     <silent> gr                 <Plug>(coc-references)
nmap     <silent> [g                 <Plug>(coc-diagnostic-prev)
nmap     <silent> ]g                 <Plug>(coc-diagnostic-next)
nmap     <silent> ff                 <Plug>(coc-fix-current)
xmap     <silent> ff                 <Plug>(coc-fix-current)
nmap     <silent><leader>a           <Plug>(coc-codeaction)
xmap     <silent><leader>as          <Plug>(coc-codeaction-selected)
nmap     <silent><leader>as          <Plug>(coc-codeaction-selected)
nmap     <silent><leader>rn          <Plug>(coc-rename)
nnoremap <silent><leader>fd          <cmd>Format<CR>
nnoremap <silent><leader>pd          <cmd>Prettier<CR>
nnoremap <silent><leader>+           :vertical resize +5<CR>
nnoremap <silent><leader>-           :vertical resize -5<CR>
nnoremap <silent><leader>h           :wincmd h<CR>
nnoremap <silent><leader>j           :wincmd j<CR>
nnoremap <silent><leader>k           :wincmd k<CR>
nnoremap <silent><leader>l           :wincmd l<CR>
nnoremap <silent><nowait><leader>di  :<C-u>CocList diagnostics<cr>
nmap <silent><leader>gh              :diffget //2<CR>
nmap <silent><leader>gl              :diffget //3<CR>
nmap <silent><leader>gs              :G<CR>
nmap <silent><leader>u               :UndotreeToggle<CR>
nmap <silent><leader>ss              <Plug>(Scalpel)

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

"make Y behave more like C and D
nnoremap Y y$

" Move code
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

" esc map
inoremap <C-c> <esc>
inoremap hh <esc> :w<CR>

"x escapes visual mode
xnoremap x <Esc>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

