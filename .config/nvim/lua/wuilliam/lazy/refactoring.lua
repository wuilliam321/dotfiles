return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-treesitter/nvim-treesitter' },
  },
  config = function()
    local refactoring = require 'refactoring'
    refactoring.setup {
      -- prompt for return type
      prompt_func_return_type = { go = true, ts = true },
      -- prompt for function parameters
      prompt_func_param_type = { go = true, ts = true },
      formatting = {
        go = {
          cmd = ':lua vim.lsp.buf.format()',
        },
      },
    }

    -- Remaps for the refactoring operations currently offered by the plugin
    local opts = { noremap = true, silent = true, expr = false }
    -- Remaps for the refactoring operations currently offered by the plugin
    vim.api.nvim_set_keymap('v', '<leader>re',
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], opts)
    vim.api.nvim_set_keymap('v', '<leader>rf',
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], opts)
    vim.api.nvim_set_keymap('v', '<leader>rv',
      [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], opts)
    vim.api.nvim_set_keymap('v', '<leader>ri',
      [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], opts)

    -- Extract block doesn't need visual mode
    vim.api.nvim_set_keymap('n', '<leader>rb', [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], opts)
    vim.api.nvim_set_keymap('n', '<leader>rbf', [[ :lua require('refactoring').refactor('Extract Block To File')<CR>]], opts)
    vim.api.nvim_set_keymap('n', '<leader>ri', [[ :lua require('refactoring').refactor('Inline Variable')<CR>]], opts)

    -- vim.api.nvim_set_keymap('v', '<leader>rr', "<Esc><Cmd>lua require('refactoring').select_refactor()<CR>", opts)

    local telescope = require('telescope')
    vim.keymap.set('v', '<leader>rr', telescope.extensions.refactoring.refactors, mapping_opts)
  end,
} 
