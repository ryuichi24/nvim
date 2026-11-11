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
		astro = { "prettier" },
		vue = { "prettier" },
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
		java = { "google-java-format" },
		xml = { "xmlformatter" },
	},
	format_on_save = {
		lsp_fallback = false,
		async = false,
		timeout_ms = 1000,
	},
	formatters = {
		prettier = {
			-- Keep plugin resolution in the project, even without a Prettier config.
			cwd = function(self, ctx)
				return require("conform.formatters.prettierd").cwd(self, ctx)
					or vim.fs.root(ctx.dirname, { "package.json", ".git" })
					or ctx.dirname
			end,
			prepend_args = function(self, ctx)
				-- Let Prettier discover project configs before using the fallback.
				if require("conform.formatters.prettierd").cwd(self, ctx) then
					return {}
				end
				local home_config = vim.fs.joinpath(vim.fn.expand("~"), ".config", "formatter", ".prettierrc")
				if vim.fn.filereadable(home_config) == 1 then
					return { "--config", home_config }
				end
				return {}
			end,
		},
	},
})
