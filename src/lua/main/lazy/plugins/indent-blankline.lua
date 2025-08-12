return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
        -- indent = { char = "┊" },
        indent = {
            char = '│',
            -- space_char_blankline = ' ',
            -- context_char = "│",
            -- show_current_context = true,
            -- show_current_context_start = true,
        },
    },
}
