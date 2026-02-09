vim.pack.add({
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	-- Code Snippet
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	-- snippet engine
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	-- VSCode like
	{ src = "https://github.com/onsails/lspkind.nvim" },
	-- Tailwind CSS
	{ src = "https://github.com/luckasRanarison/tailwind-tools.nvim" },
	-- JSON Schema
	{ src = "https://github.com/b0o/SchemaStore.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
})

local cmp = require("cmp")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

--
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		opts.desc = "Show LSP references"
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

		opts.desc = "Go to declaration"
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- go to declaration

		opts.desc = "See available code actions"
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

		vim.keymap.set("n", "<leader>ef", vim.diagnostic.open_float, { desc = "[E]xpand diagnostic message" })
		vim.keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { desc = "Next error" })
		vim.keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { desc = "Previous error" })
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

-- https://github.com/neovim/nvim-lspconfig?tab=readme-ov-file#important-%EF%B8%8F
vim.lsp.enable({
	"lua_ls",
	"gopls",
	"vtsls",
	"tailwindcss",
	"clangd",
	"jsonls",
	"sourcekit",
	"sqlls",
})

-- mason
require("mason").setup()

vim.keymap.set("n", "<leader>lm", "<cmd>Mason<CR>", { desc = "Open Mason GUI" })
