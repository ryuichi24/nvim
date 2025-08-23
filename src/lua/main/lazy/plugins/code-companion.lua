return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
        require("codecompanion").setup {
            strategies = {
                -- Change the default chat adapter
                chat = {
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                },
                agent = {
                    adapter = "copilot",
                },
            },
            opts = {
                -- Set debug logging
                log_level = "DEBUG",
            },

        }

        vim.keymap.set({ "n", "v" }, "<leader>oa", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
        vim.keymap.set({ "n", "v" }, "<leader>oc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
        vim.keymap.set("v", "<leader>oi",
            function()
                -- https://codecompanion.olimorris.dev/configuration/inline-assistant.html
                vim.api.nvim_feedkeys(":'<,'>CodeCompanion /buffer", "c", false)
            end, { desc = "CodeCompanion buffer on selection" })

        vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
        vim.cmd([[cab cc CodeCompanion]])          -- Expand 'cc' into 'CodeCompanion' in the command line
        vim.cmd([[cab cci CodeCompanion /buffer]]) -- Expand 'cc' into 'CodeCompanion' in the command line
    end
}
