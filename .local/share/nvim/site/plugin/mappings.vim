"=================================================================Normal mode

" Open files / find files
nnoremap <leader>pp :GFiles<Cr>
nnoremap <leader>pg :PRg<Cr>
nnoremap <leader>ff :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>pa :Files<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pw :PRg <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>phw :h <C-R>=expand("<cword>")<CR><CR>

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ss <Plug>(Scalpel)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <leader>qf <Plug>(coc-fix-current)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction)

"reload vimrc
nnoremap <leader>so :source ~/.vimrc<CR>

" Run jest for current test
"nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>
"nnoremap <leader>tp :call CocAction('runCommand', 'jest.projectTest')<CR>
nnoremap <leader>p :call CocAction('runCommand', 'prettier.formatFile')<CR>

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>

" Manage extensions.
"nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>

" Show commands.
"nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>

" Find symbol of current doleadert.
"nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>

" Search workspace symbols.leader
"nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>

" Do default action for nexleaderm.
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>

" Do default action for preleader item.
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
"nmap <silent> <C-s> <Plug>(coc-range-select)

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Use K to show documentation in preview window.
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

"nmap <leader>f :Format<CR>
"nmap <leader>fp :Prettier<CR>

nmap <leader>gh :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>
nmap <leader>gs :G<CR>

nnoremap <leader>+ :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

" Formatting selected code.
"xmap <leader>p  <Plug>(coc-format-selected)
"nmap <leader>p  <Plug>(coc-format-selected)

"make Y behave more like C and D
nnoremap Y y$

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
omap ic <Plug>(coc-classobj-i)
omap ac <Plug>(coc-classobj-a)

" Move code
"vnoremap J :m '>+1<CR>gv=gv
"vnoremap K :m '<-2<CR>gv=gv

" Spell using fzf
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'window': { 'width': 0.8, 'height': 0.8 } })
endfunction
nnoremap z= :call FzfSpell()<CR>

"=================================================================Insert mode

" autcomplete improvements
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" esc map
inoremap <C-c> <esc>
inoremap hh <esc> :w<CR>

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

"=================================================================Visual mode

xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
xmap <silent> <leader>qf <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
xmap <silent> <C-s> <Plug>(coc-range-select)

"x escapes visual mode
xnoremap x <Esc>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
