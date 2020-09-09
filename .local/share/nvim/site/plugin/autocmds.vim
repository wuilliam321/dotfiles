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
      autocmd BufEnter * lua require'completion'.on_attach()
      autocmd BufEnter * lua require'diagnostic'.on_attach()

      " Spell using fzf
      function! FzfSpellSink(word)
        exe 'normal! "_ciw'.a:word
      endfunction
      function! FzfSpell()
        let suggestions = spellsuggest(expand("<cword>"))
        return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'window': { 'width': 0.8, 'height': 0.8 } })
      endfunction
      nnoremap z= :call FzfSpell()<CR>

      if (exists(':CocList'))
        "autocmd CursorHold * silent call CocActionAsync('highlight')
        "autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
      endif
  augroup END
endfunction

call s:WAutocmds()
