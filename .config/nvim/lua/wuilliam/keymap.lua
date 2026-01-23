vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- -- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.cmd [[ au BufWinLeave *.go mkview ]]
vim.cmd [[ au BufWinEnter *.go silent! loadview]]

vim.keymap.set('n', '<leader>zf', function()
  if vim.fn.foldlevel(vim.fn.line(".")) == 0 then
    vim.cmd [[normal zfa{]]
  end
  print()
end, { desc = 'Create fold' })

vim.keymap.set('i', '<C-c>', '<esc>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('x', 'x', '<Esc>')

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])

vim.keymap.set("x", "<leader>P", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Main keymaps
vim.keymap.set('n', '<leader>ff', ':Ex<cr>')
vim.keymap.set('n', '<C-n>', '<cmd>cnext<cr>zz')
vim.keymap.set('n', '<C-p>', '<cmd>cprev<cr>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'b', 'bzz')


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
