-- https://www.youtube.com/watch?v=xdXE1tOT-qg
-- https://www.youtube.com/watch?v=iqdCshrIKIg
return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").setup {
                defaults = {
                    path_display = { "smart" }
                },
                pickers = {
                    find_files = {
                        theme = "ivy",
                        hidden = true,
                        find_command = { "rg", "--files", "--hidden", "--glob", "!.git" }
                    }
                }
            }
            vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
            vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Find recent files" })
            vim.keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", { desc = "Find string in cwd" })
            vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fc", function()
                    require("telescope.builtin").find_files {
                        cwd = vim.fn.stdpath("config")
                    }
                end,
                { desc = "Find files in neovim config dir" })
        end
    }
}
