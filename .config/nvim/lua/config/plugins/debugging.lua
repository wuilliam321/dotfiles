return {
  {
    'puremourning/vimspector',
    event = 'VimEnter',
    dependencies = { 'tyru/current-func-info.vim' },
    config = function()
      vim.keymap.set('n', '<leader>da', '<cmd>call vimspector#LaunchWithSettings( #{ configuration: "delve" } )<cr>',
        { desc = '[D]ebug [A]ll' })
      vim.keymap.set('n', '<leader>df', '<cmd>call vimspector#LaunchWithSettings( #{ configuration: "file" } )<cr>',
        { desc = '[D]ebug [F]ile' })
      vim.keymap.set('n', '<leader>ds', '<cmd>VimspectorReset<cr>', { desc = '[D]ebug [S]top' })
      vim.keymap.set('n', '<leader>bp', '<cmd>call vimspector#ToggleBreakpoint()<cr>', { desc = '[B]reak [P]oint' })
      vim.keymap.set('n', '<leader>dn', '<cmd>call vimspector#StepOver()<cr>', { desc = '[D]ebug [N]ext' })
      vim.keymap.set('n', '<leader>dc', '<cmd>call vimspector#Continue()<cr>', { desc = '[D]ebug [C]ontinue' })

      -- uses tyru/current-func-info.vim
      vim.keymap.set(
        'n',
        '<leader>dm',
        '<cmd>call vimspector#LaunchWithSettings( #{ configuration: "method", Test: "^" . cfi#format("%s", "") . "$" } )<cr>',
        { desc = '[D]ebug [M]ethod' }
      )
    end,
  },
}
