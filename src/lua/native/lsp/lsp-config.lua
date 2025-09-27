vim.pack.add({
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    -- Code Snippet
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    -- VSCode like
    { src = "https://github.com/onsails/lspkind.nvim" },
    -- Tailwind CSS
    { src = "https://github.com/luckasRanarison/tailwind-tools.nvim" },
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

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
    end,
})

--
vim.diagnostic.config({
    -- virtual_lines = true,
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
})


-- LSP Configurations

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

local lspkind = require("lspkind")

-- cmp
cmp.setup({
    completeopt = "menu,menuone,preview,noinsert",
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions,
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    }),
    formatting = {
        format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
        }),
    },
})


cmp.setup.filetype("sql", {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    },
})

-- Setup Code Snippet
local luasnip = require("luasnip.loaders.from_vscode")
luasnip.lazy_load({ paths = { "~/.config/nvim/src/lua/native/lsp/snippets/" } })

-- Tailwind CSS
local tailwind_tools = require("tailwind-tools")
-- https://github.com/luckasRanarison/tailwind-tools.nvim?tab=readme-ov-file#installation
vim.api.nvim_create_autocmd('PackChanged', {
    desc = 'Handle tailwind-tools.nvim updates',
    group = vim.api.nvim_create_augroup('', { clear = true }),
    callback = function(event)
        if event.data.kind == 'update' and event.data.spec.name == 'tailwind-tools' then
            vim.notify('tailwind-tools updated, running ... :UpdateRemotePlugins', vim.log.levels.INFO)
            ---@diagnostic disable-next-line: param-type-mismatch
            local ok = pcall(vim.cmd, 'UpdateRemotePlugins')
            if ok then
                vim.notify('UpdateRemotePlugins completed successfully!', vim.log.levels.INFO)
            else
                vim.notify('UpdateRemotePlugins command not available yet, skipping', vim.log.levels.WARN)
            end
        end
    end,
})

tailwind_tools.setup({
})
