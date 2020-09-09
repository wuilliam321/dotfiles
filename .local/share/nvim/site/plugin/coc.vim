if (exists(':CocList'))
  function! s:WCoc()
    augroup WCoc
        autocmd!
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        " autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
        autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
    augroup END
  endfunction

  call s:WCoc()
endif

