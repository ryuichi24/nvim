local logger = require("utils.logger"):new({ name = "lsp-config.config" })

logger:debug("Loading lsp-config.config...")

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
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
})

--
vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = true,
	underline = true,
	update_in_insert = true,
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
			[vim.diagnostic.severity.INFO] = "InfoMsg",
			[vim.diagnostic.severity.HINT] = "HintMsg",
		},
	},
})

vim.opt.completeopt = "menu,menuone,preview,noinsert"

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config["*"] = {
	capabilities = capabilities,
}

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
	"typos_lsp",
	"powershell_es",
	"jdtls",
})

-- cmp
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
	}),
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
	}),
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 100,
			ellipsis_char = "...",
		}),
	},
	capabilities = capabilities,
})

-- mason
require("mason").setup({})
vim.keymap.set("n", "<leader>lm", "<cmd>Mason<CR>", { desc = "Open Mason GUI" })

-- keymaps
-- :checkhealth vim.deprecated

vim.keymap.set("n", "<leader>li", ":lua print(vim.inspect(vim.lsp.get_clients()))<CR>", { desc = "LSP Info" })
vim.keymap.set("n", "<leader>lc", function()
	local clients = vim.lsp.get_clients()
	if vim.tbl_isempty(clients) then
		print("No LSP clients attached")
		return
	end

	for _, client in ipairs(clients) do
		local bufs = {}
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.lsp.buf_is_attached(buf, client.id) then
				table.insert(bufs, vim.api.nvim_buf_get_name(buf))
			end
		end

		print(
			string.format(
				"Name: %s | Root: %s | Filetypes: %s | Buffers: %d",
				client.name,
				client.config.root_dir or "nil",
				table.concat(client.config.filetypes or {}, ","),
				#bufs
			)
		)
	end
end, { desc = "Compact LSP Info" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }

		opts.desc = "Format"
		vim.keymap.set("n", "<leader>ll", vim.lsp.buf.format, opts)

		-- set keybinds
		opts.desc = "Show LSP references"
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

		opts.desc = "Go to declaration"
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

		opts.desc = "See available code actions"
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		opts.desc = "Expand diagnostic message"
		vim.keymap.set("n", "<leader>ef", vim.diagnostic.open_float, opts)

		-- rename symbol
		opts.desc = "Rename symbol"
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		-- focus on floating diagnostic message
		opts.desc = "Focus on popup"
		vim.keymap.set("n", "<C-f>", function()
			vim.lsp.buf.hover()
		end, opts)

		local ERROR_DIAGNOSTIC = 1
		opts.desc = "Go to next error"
		vim.keymap.set("n", "<leader>en", function()
			vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_next({ severity = ERROR_DIAGNOSTIC }), count = 1 })
		end, opts)

		opts.desc = "Go to prev error"
		vim.keymap.set("n", "<leader>ep", function()
			vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_prev({ severity = ERROR_DIAGNOSTIC }), count = 1 })
		end, opts)

		local WARN_DIAGNOSTIC = 2
		opts.desc = "Go to next warn"
		vim.keymap.set("n", "<leader>wn", function()
			vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_next({ severity = WARN_DIAGNOSTIC }), count = 1 })
		end, opts)

		opts.desc = "Go to prev warn"
		vim.keymap.set("n", "<leader>wp", function()
			vim.diagnostic.jump({ diagnostic = vim.diagnostic.get_prev({ severity = WARN_DIAGNOSTIC }), count = 1 })
		end, opts)
	end,
})
