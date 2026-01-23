return {
  {
    'airblade/vim-gitgutter',
    config = function()
      vim.keymap.set('n', '<leader>ghp', '@<Plug>(GitGutterPreviewHunk)')
      vim.keymap.set('n', '<leader>ghu', '@<Plug>(GitGutterUndoHunk)')
      vim.keymap.set('n', '<leader>ghs', '@<Plug>(GitGutterStageHunk)')
      vim.keymap.set('x', '<leader>ghs', '@<Plug>(GitGutterStageHunk)')
      vim.cmd([[GitGutterLineNrHighlightsEnable]])
    end,
  },
}
