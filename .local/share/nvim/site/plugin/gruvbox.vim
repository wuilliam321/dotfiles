let g:gruvbox_italic = 1
let g:gruvbox_termcolors=16

" theme remap
nnoremap <silent><leader> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent><leader> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent><leader> coh :call gruvbox#hls_toggle()<CR>
nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
