vim.pack.add({
    { src = "https://github.com/akinsho/bufferline.nvim" }
})

require("bufferline").setup({
    options = {
        mode = "tabs",
        separator_style = "slant",
    }
})
