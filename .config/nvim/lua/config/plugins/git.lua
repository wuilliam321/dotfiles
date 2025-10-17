return {
  {
    'airblade/vim-gitgutter',
    config = function()
      vim.keymap.set('n', '<leader>ghp', '@<Plug>(GitGutterPreviewHunk)')
      vim.keymap.set('n', '<leader>ghu', '@<Plug>(GitGutterUndoHunk)')
      vim.keymap.set('n', '<leader>ghs', '@<Plug>(GitGutterStageHunk)')
      vim.keymap.set('x', '<leader>ghs', '@<Plug>(GitGutterStageHunk)')
      vim.cmd([[GitGutterSignsDisable]])
    end,
  },
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gs', vim.cmd.G, { desc = '[G]it [S]tatus' })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
