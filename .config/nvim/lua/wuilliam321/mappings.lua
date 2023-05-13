local opts = {noremap = true, silent = true, nowait = true}
local nnoremap = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, opts) end
local vnoremap = function(lhs, rhs) vim.keymap.set('v', lhs, rhs, opts) end
local xnoremap = function(lhs, rhs) vim.keymap.set('v', lhs, rhs, opts) end
local onoremap = function(lhs, rhs) vim.keymap.set('o', lhs, rhs, opts) end
local inoremap = function(lhs, rhs) vim.keymap.set('i', lhs, rhs, opts) end
local tnoremap = function(lhs, rhs) vim.keymap.set('t', lhs, rhs, opts) end

-- find
nnoremap( '<leader>pa', function() require("wuilliam321.finders").projects() end )
nnoremap( '<leader>pp', function() require("wuilliam321.finders").git_files() end )
nnoremap( '<leader>pf', function() require("wuilliam321.finders").project_find() end )
nnoremap( '<leader>pg', function() require("wuilliam321.finders").project_grep() end )
nnoremap( '<leader>pb', function() require("wuilliam321.finders").buffers() end )
-- nnoremap( '<leader>ff', function() require("wuilliam321.finders").file_browser() end )
nnoremap( '<leader>ff', ':Ex<cr>' )
nnoremap( '<leader>ph', function() require("wuilliam321.finders").help_tags() end )
nnoremap( '<leader>di', function() require("wuilliam321.finders").buffer_diagnostics() end )
nnoremap( '<leader>fg', function() require("wuilliam321.finders").buffer_find() end )
nnoremap( '<leader>cs', function() require("wuilliam321.finders").cheatsheets({filetype = vim.bo.filetype }) end )

-- windows management / navigation
nnoremap( '<leader>h', ':wincmd h<cr>' )
nnoremap( '<leader>j', ':wincmd j<cr>' )
nnoremap( '<leader>k', ':wincmd k<cr>' )
nnoremap( '<leader>l', ':wincmd l<cr>' )
nnoremap( '<leader>+', ':vertical resize +5<cr>' )
nnoremap( '<leader>-', ':vertical resize -5<cr>' )
nnoremap( '<c-w>a', ':CloseOthers<cr>' )

-- center on next/prev
nnoremap( 'n', 'nzzzv' )
nnoremap( 'N', 'Nzzzv' )

-- code actions
nnoremap( '<leader>rn', function() vim.lsp.buf.rename() end )
nnoremap( '<leader>a', function() vim.lsp.buf.range_code_action() end )
nnoremap( '<leader>ca', function() vim.lsp.buf.code_action() end )
vnoremap( '<leader>a', function() vim.lsp.buf.range_code_action() end )
vnoremap( '<leader>ca', function() vim.lsp.buf.code_action() end )
nnoremap( '<leader>fd', function() vim.lsp.buf.format { async = true } end )
vnoremap( '<leader>fd', function() vim.lsp.buf.range_formatting() end )
nnoremap( '<leader>pd', '<cmd>PrettierAsync<cr>' )
nnoremap( 'z=', function() require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({ previewer = false })) end )

-- testing/debugging
nnoremap( '<leader>da', '<cmd>call vimspector#LaunchWithSettings( #{ configuration: "run" } )<cr>' )
nnoremap( '<leader>df', '<cmd>call vimspector#LaunchWithSettings( #{ configuration: "file" } )<cr>' )
-- uses tyru/current-func-info.vim
nnoremap( '<leader>dm', '<cmd>call vimspector#LaunchWithSettings( #{ configuration: "method", Test: "^" . cfi#format("%s", "") . "$" } )<cr>' )
nnoremap( '<leader>ds', '<cmd>VimspectorReset<cr>' )
nnoremap( '<leader>bp', '<cmd>call vimspector#ToggleBreakpoint()<cr>' )
nnoremap( '<leader>dn', '<cmd>call vimspector#StepOver()<cr>' )
nnoremap( '<leader>dc', '<cmd>call vimspector#Continue()<cr>' )

-- harpoon
nnoremap( '<leader>mb', function() require("harpoon.mark").add_file() end )
nnoremap( '<leader>md', function() require("harpoon.mark").rm_file() end )
nnoremap( '<leader>mp', function() require("harpoon.mark").promote() end )
nnoremap( '<leader>mc', function() require("harpoon.mark").clear_all(4) end)
nnoremap( '<leader>mm', function() require("harpoon.ui").toggle_quick_menu() end )
nnoremap( '<leader>mq', function() require("harpoon.ui").to_quickfix_list() end )
nnoremap( '<leader>mu', function() require("harpoon.ui").nav_file(1) end)
nnoremap( '<leader>me', function() require("harpoon.ui").nav_file(2) end)
nnoremap( '<leader>mo', function() require("harpoon.ui").nav_file(3) end)
nnoremap( '<leader>ma', function() require("harpoon.ui").nav_file(4) end)
nnoremap( '<leader>tu', function() require("harpoon.term").gotoTerminal(1) end)
nnoremap( '<leader>te', function() require("harpoon.term").gotoTerminal(2) end)
nnoremap( '<leader>to', function() require("harpoon.term").gotoTerminal(3) end)
nnoremap( '<leader>ta', function() require("harpoon.term").gotoTerminal(4) end)
-- nnoremap( "<u", function() require('harpoon.term').sendcommand(1, 1) end )
-- nnoremap( "<leader>ce", function() require("harpoon.term").sendCommand(2, 2)  end)
-- nnoremap( "<leader>co", function() require("harpoon.term").sendCommand(3, 3)  end)
-- nnoremap( "<leader>ca", function() require("harpoon.term").sendCommand(4, 4)  end)

-- code navigation
nnoremap( 'K', function() vim.lsp.buf.hover() end )
nnoremap( 'gD', function() vim.lsp.buf.declaration() end )
nnoremap( 'gd', function() require("wuilliam321.finders").lsp_definitions() end )
nnoremap( 'gi', function() require("wuilliam321.finders").lsp_implementations() end )
nnoremap( 'gt', function() require("wuilliam321.finders").lsp_type_definitions() end )
nnoremap( 'gr', function() require("wuilliam321.finders").lsp_references() end )
nnoremap( 'g0', function() require("telescope.builtin").lsp_document_symbols(require("telescope.themes").get_dropdown({})) end )
nnoremap( 'gW', function() require("wuilliam321.finders").find_symbol() end )
nnoremap( '<c-k>', function() vim.lsp.buf.signature_help() end )
nnoremap( '<leader>pw', function() require("wuilliam321.finders").project_word() end )
nnoremap( '<leader>qf', function() require("wuilliam321.finders").quickfix() end )
nnoremap( '[g', function() vim.diagnostic.goto_prev() vim.api.nvim_command('normal zz') end )
nnoremap( ']g', function() vim.diagnostic.goto_next() vim.api.nvim_command('normal zz') end )
nnoremap( '<leader>td', '<cmd>:vsplit<cr><cmd>:e ~/dotfiles/notes.md<cr>' )
nnoremap( '<C-h>', ':cprev<cr>zt' )
nnoremap( '<C-l>', ':cnext<cr>zt' )

-- Git
nnoremap( '<leader>gs', ':G<cr>' )
nnoremap( '<leader>u', ':UndotreeToggle<cr>' )
-- nnoremap( '<leader>m', ':MaximizerToggle<cr>' )

-- remap to prevent leader h to be messed
nnoremap( '<Space>ghp', '@<Plug>(GitGutterPreviewHunk)' )
nnoremap( '<Space>ghu', '@<Plug>(GitGutterUndoHunk)' )
nnoremap( '<Space>ghs', '@<Plug>(GitGutterStageHunk)' )
xnoremap( '<Space>ghs', '@<Plug>(GitGutterStageHunk)' )

-- Misc
-- make Y behave more like C and D
nnoremap( 'Y', 'y$' )
onoremap( 'ao', ':normal! v$%<cr>' )
-- inoremap( "<expr><C-k>", "BDG_GetDigraph()" )

-- add more undo beakpoints
inoremap( ',', ',<c-g>u' )
inoremap( '.', '.<c-g>u' )
inoremap( '!', '!<c-g>u' )
inoremap( '?', '?<c-g>u' )
inoremap( '<space>', '<space><c-g>u' ) -- This make abbreviations not to work

-- esc map
inoremap( '<C-c>', '<esc>' )
tnoremap( '<Esc>', '<C-\\><C-n>' )

-- x escapes visual mode
xnoremap( 'x', '<Esc>' )

-- Refactoring
vnoremap( '<leader>rr', function() require('telescope').extensions.refactoring.refactors() end )
-- vnoremap( '<leader>re', function() require("refactoring").refactor('Extract Function') end )
-- vnoremap( '<leader>rv', function() require('refactoring').refactor('Extract Variable') end )
-- vnoremap( '<leader>rf', function() require('refactoring').refactor('Extract Function To File') end )
-- vnoremap( '<leader>ri', function() require('refactoring').refactor('Inline Variable') end )

-- -- Extract block doesn't need visual mode
-- nnoremap( '<leader>rb', function() require('refactoring').refactor('Extract Block') end )
-- nnoremap( '<leader>rbf', function() require('refactoring').refactor('Extract Block To File') end )

-- -- Inline variable can also pick up the identifier currently under the cursor without visual mode
-- nnoremap( '<leader>ri', function() require('refactoring').refactor('Inline Variable') end )

-- gruvbox
-- nnoremap( '<leader>[oh', ':call gruvbox#hls_show()<CR>' )
-- nnoremap( '<leader>]oh', ':call gruvbox#hls_hide()<CR>' )
-- nnoremap( '<leader>coh', ':call gruvbox#hls_toggle()<CR>' )
nnoremap( '*', ':let @/ = ""<CR>:call gruvbox#hls_show()<CR>*' )
nnoremap( '/', ':let @/ = ""<CR>:call gruvbox#hls_show()<CR>/' )
nnoremap( '?', ':let @/ = ""<CR>:call gruvbox#hls_show()<CR>?' )

