function! s:WAutocmds()
  fun! TrimWhitespace()
      let l:save = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(l:save)
  endfun

  augroup WAutocmds
      autocmd!
      autocmd VimEnter * :VimApm
      autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
      autocmd BufWritePre * :call TrimWhitespace()
      autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
      autocmd FileType markdown setlocal spell
      autocmd FileType gitcommit setlocal spell
      autocmd FileType gitcommit setlocal complete+=kspell

      " Spell using fzf
      function! FzfSpellSink(word)
        exe 'normal! "_ciw'.a:word
      endfunction
      function! FzfSpell()
        let suggestions = spellsuggest(expand("<cword>"))
        return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'window': { 'width': 0.8, 'height': 0.8 } })
      endfunction
      nnoremap z= :call FzfSpell()<CR>

      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
      autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
  augroup END
endfunction

call s:WAutocmds()
