vim.pack.add({
    { src = "https://github.com/tpope/vim-dadbod" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
    { src = "https://github.com/kristijanhusak/vim-dadbod-completion" }
})

vim.keymap.set('n', '<leader>dv', "<Cmd>DBUIToggle<CR>")
vim.keymap.set('n', '<leader>dx', "<Cmd>DBUIClose<CR><Cmd>tabclose<CR>")
