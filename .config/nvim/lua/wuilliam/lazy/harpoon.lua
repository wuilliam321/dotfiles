return {
  'ThePrimeagen/harpoon',
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>mb", function() harpoon:list():add() end, { desc = '[M]ark [B]uffer' })
    vim.keymap.set("n", "<leader>mm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = '[M]arks [M]enu' })

    vim.keymap.set("n", "<leader>mu", function() harpoon:list():select(1) end, { desc = 'Go [M]ark [U]' })
    vim.keymap.set("n", "<leader>me", function() harpoon:list():select(2) end, { desc = 'Go [M]ark [E]' })
    vim.keymap.set("n", "<leader>mo", function() harpoon:list():select(3) end, { desc = 'Go [M]ark [O]' })
    vim.keymap.set("n", "<leader>ma", function() harpoon:list():select(4) end, { desc = 'Go [M]ark [A]' })

    -- Toggle previous & next buffers stored within Harpoon list
    -- vim.keymap.set("n", "<C-S-H>", function() harpoon:list():prev() end)
    -- vim.keymap.set("n", "<C-S-L>", function() harpoon:list():next() end)
  end,
}
