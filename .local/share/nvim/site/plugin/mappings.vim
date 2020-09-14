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

nnoremap <silent> gD                 <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd                 <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K                  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi                 <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k>              <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gt                 <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr                 <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0                 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW                 <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> [g                 <cmd>NextDiagnosticCycle<CR>
nnoremap <silent> ]g                 <cmd>PrevDiagnosticCycle<CR>
nmap     <silent> ff                 <Plug>(coc-fix-current)
xmap     <silent> ff                 <Plug>(coc-fix-current)
nnoremap <silent><leader>fd          <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent><leader>pd          <cmd>PrettierAsync<CR>
nnoremap <silent><leader>+           :vertical resize +5<CR>
nnoremap <silent><leader>-           :vertical resize -5<CR>
nnoremap <silent><leader>h           :wincmd h<CR>
nnoremap <silent><leader>j           :wincmd j<CR>
nnoremap <silent><leader>k           :wincmd k<CR>
nnoremap <silent><leader>l           :wincmd l<CR>
nnoremap <silent><nowait><leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent><nowait><leader>a   <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent><nowait><leader>di  <cmd>OpenDiagnostic<CR>
nmap <silent><leader>gh              :diffget //2<CR>
nmap <silent><leader>gl              :diffget //3<CR>
nmap <silent><leader>gs              :G<CR>
nmap <silent><leader>u               :UndotreeToggle<CR>
nmap <silent><leader>ss              <Plug>(Scalpel)

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"map <c-p> to manually trigger completion
inoremap <silent><expr> <c-p> completion#trigger_completion()

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
