local logger = require("utils.logger"):new({ name = "plugins.conform" })

logger:debug("Loading plugins.conform...")

vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		go = { "goimports", "gofmt" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		liquid = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
	},
	format_on_save = {
		lsp_fallback = false,
		async = false,
		timeout_ms = 1000,
	},
	formatters = {
		prettier = {
			-- how conform finds the prettier config file
			cwd = function(self, ctx)
				-- Try project root first
				local project_root = require("conform.formatters.prettierd").cwd(self, ctx)
				if project_root then
					return project_root
				end

				-- Fallback to home directory
				local home_config = vim.fs.joinpath(vim.fn.expand("~"), ".config", "formatter", ".prettierrc")
				print("Checking for prettier config at: " .. home_config)
				if vim.fn.filereadable(home_config) == 1 then
					return vim.fn.expand("~")
				end

				return nil
			end,
		},
	},
})
