vim.pack.add({
    { src = "https://github.com/iamcco/markdown-preview.nvim" }
})

vim.fn["mkdp#util#install"]()

vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", { noremap = true, silent = true })
