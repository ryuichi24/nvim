vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    -- Code Snippet
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
})
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

--
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        print("LspAttach fired for buffer " .. ev.buf)

        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- go to declaration
    end,
})


-- Lua
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- Suppress warning of the "vim" global variable undefined
                globals = { "vim" },
            }
        }
    }
})

-- Go
lspconfig.gopls.setup({
    capabilities = capabilities,
    settings = {}
})

-- Typscript : https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vtsls
lspconfig.vtsls.setup({
    capabilities = capabilities,
    settings = {}
})

-- C/C++
lspconfig.clangd.setup({
    capabilities = capabilities,
    settings = {}
})

-- cmp
cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})

-- Setup Code Snippet
local luasnip = require("luasnip.loaders.from_vscode")
luasnip.lazy_load({ paths = { "~/.config/nvim/src/lua/main/lazy/lsp/snippets/" } })

