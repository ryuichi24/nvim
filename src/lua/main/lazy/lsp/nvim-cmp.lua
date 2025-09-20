return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",           -- source for text in buffer
        "hrsh7th/cmp-path",             -- source for file system paths
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",     -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim",         -- vs-code like pictograms
        {
            "github/copilot.vim",
            config = function()
                -- https://mattbatman.com/remapping-tab-completion-for-github-copilot-in-neovim/
                vim.api.nvim_set_keymap('i', '<M-CR>', 'copilot#Accept("<CR>")',
                    { expr = true, noremap = true, silent = true })
                vim.g.copilot_no_tab_map = true
            end
        }
    },
    config = function()
        local cmp = require("src.lua.native.plugins.lsp_plugins.cmp")

        local luasnip = require("luasnip")

        local lspkind = require("lspkind")

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview",
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp" }, -- lsp
                { name = "luasnip" },  -- snippets
                { name = "buffer" },   -- text within current buffer
                { name = "path" },     -- file system paths
            }),

            -- configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
        })


        -- https://github.com/exosyphon/nvim/blob/main/lua/plugins/lsp.lua
        -- `/` cmdline setup.
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline({
                ["<C-j>"] = {
                    c = function(callback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            callback()
                        end
                    end,
                },
                ["<C-k>"] = {
                    c = function(callback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            callback()
                        end
                    end,
                }
            }),
            sources = {
                { name = "buffer" },
            },
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline({
                -- https://github.com/LazyVim/LazyVim/discussions/2487
                ["<C-j>"] = {
                    c = function(callback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            callback()
                        end
                    end,
                },
                ["<C-k>"] = {
                    c = function(callback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            callback()
                        end
                    end,
                }
            }),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })
    end,
}
