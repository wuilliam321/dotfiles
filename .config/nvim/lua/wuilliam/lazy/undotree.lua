return {
    'mbbill/undotree',
    config = function()
      vim.opt.backup = false
      vim.opt.swapfile = false
      vim.opt.writebackup = false
      vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
      vim.opt.undofile = true

      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
}
