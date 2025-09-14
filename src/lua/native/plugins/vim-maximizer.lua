vim.pack.add({
    { src = "https://github.com/szw/vim-maximizer" }
})

vim.keymap.set("n", "<leader>wm", "<cmd>MaximizerToggle<CR>", { desc = "Toggle Maximizer" })
