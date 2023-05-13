augroup python_ft
  autocmd!
  autocmd FileType python autocmd! TextChangedI,TextChanged,BufEnter <buffer> lua require'lint'.try_lint()
augroup END
