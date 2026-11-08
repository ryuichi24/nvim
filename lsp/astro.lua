---@brief
--- Install with `:MasonInstall astro-language-server`.
--- Prefer project-local TypeScript, falling back to Mason's bundled SDK.

---@type vim.lsp.Config
return {
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	init_options = {
		typescript = {},
	},
	before_init = function(_, config)
		local function valid_sdk(path)
			return type(path) == "string"
				and (
					vim.fn.filereadable(path .. "/typescript.js") == 1
					or vim.fn.filereadable(path .. "/tsserverlibrary.js") == 1
				)
		end

		local typescript = config.init_options.typescript
		if valid_sdk(typescript.tsdk) then
			return
		end

		local tsdk = require("lspconfig.util").get_typescript_server_path(config.root_dir)
		if not valid_sdk(tsdk) then
			local mason_tsdk = vim.fn.stdpath("data")
				.. "/mason/packages/astro-language-server/node_modules/typescript/lib"
			if vim.fn.filereadable(mason_tsdk .. "/typescript.js") == 1 then
				tsdk = mason_tsdk
			end
		end
		typescript.tsdk = tsdk
	end,
}
