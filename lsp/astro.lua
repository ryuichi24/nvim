---@brief
--- Install with `:MasonInstall astro-language-server`.
--- Install TypeScript in the project so the server can resolve its SDK.

---@type vim.lsp.Config
return {
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	init_options = {
		typescript = {},
	},
	before_init = function(_, config)
		if not config.init_options.typescript.tsdk then
			config.init_options.typescript.tsdk = require("lspconfig.util").get_typescript_server_path(config.root_dir)
		end
	end,
}
