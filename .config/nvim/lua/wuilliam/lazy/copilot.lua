return {
    {
        'github/copilot.vim',
        config = function()
            vim.g.copilot_filetypes = { VimspectorPrompt = false }
        end,
    },
}

