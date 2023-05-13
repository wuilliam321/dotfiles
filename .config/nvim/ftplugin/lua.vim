function! s:GoAutocmds()
  augroup GOAutocmds
      autocmd!
      autocmd FileType lua autocmd! BufWritePre <buffer> call LuaFormat()
  augroup END
endfunction

call s:GoAutocmds()
