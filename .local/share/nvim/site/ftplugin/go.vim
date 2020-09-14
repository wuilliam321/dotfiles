setlocal noexpandtab
setlocal shiftwidth=4
setlocal tabstop=4
setlocal autowrite

nnoremap <leader>fd :GoFmt<CR>

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command='goimports'
let g:go_fmt_autosave=0
let g:gofmt_exe = 'goimports'
let g:go_doc_popup_window = 1
let g:go_diagnostics_enabled = 1
let g:go_highlight_build_constraints = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_fields = 0
let g:go_highlight_functions = 0
let g:go_highlight_methods = 0
let g:go_highlight_operators = 0
let g:go_highlight_structs = 0
let g:go_highlight_types = 0
let g:go_highlight_function_parameters = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_generate_tags = 0
let g:go_highlight_format_strings = 0
let g:go_highlight_variable_declarations = 0
let g:go_auto_sameids = 1
let g:go_list_type = "quickfix"
