vim.pack.add({
    { src = "https://github.com/lukas-reineke/indent-blankline.nvim" }
})

require("ibl").setup({
    -- indent = { char = "┊" },
    indent = {
        char = '│',
        -- space_char_blankline = ' ',
        -- context_char = "│",
        -- show_current_context = true,
        -- show_current_context_start = true,
    },
})
