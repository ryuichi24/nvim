vim.pack.add({
    { src = "https://github.com/github/copilot.vim" },
})

-- GitHub Copilot Settings
-- vim.keymap.set("i", "<M-CR>", 'copilot#Accept("<CR>")', { expr = true, noremap = true, silent = true })

vim.g.copilot_no_tab_map = false

vim.g.copilot_filetypes = {
    ["*"] = true,        -- Enable for all filetypes
    ["markdown"] = true, -- Disable for markdown files
}
