vim.pack.add({
    { src = "https://github.com/github/copilot.vim" }
})

vim.api.nvim_set_keymap('i', '<M-CR>', 'copilot#Accept("<CR>")',
    { expr = true, noremap = true, silent = true })

vim.g.copilot_no_tab_map = true

vim.g.copilot_filetypes = {
    ["*"] = true,        -- Enable for all filetypes
    ["markdown"] = true, -- Disable for markdown files
}
