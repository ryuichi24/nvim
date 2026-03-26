--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/jsonls.lua
---@brief
---
--- https://github.com/hrsh7th/vscode-langservers-extracted
---
--- vscode-json-language-server, a language server for JSON and JSON schema
---
--- `vscode-json-language-server` can be installed via `npm`:
--- ```sh
--- npm i -g vscode-langservers-extracted
--- ```
---
--- `vscode-json-language-server` only provides completions when snippet support is enabled. If you use Neovim older than v0.10 you need to enable completion, install a snippet plugin and add the following override to your language client capabilities during setup.
---
--- ```lua
--- --Enable (broadcasting) snippet capability for completion
--- local capabilities = vim.lsp.protocol.make_client_capabilities()
--- capabilities.textDocument.completion.completionItem.snippetSupport = true
---
--- vim.lsp.config('jsonls', {
---   capabilities = capabilities,
--- })
--- ```

vim.filetype.add({
	filename = {
		-- vscode config files
		["settings.json"] = "jsonc",
		["keybindings.json"] = "jsonc",
	},
})

---@type vim.lsp.Config
return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = {
		provideFormatter = true,
	},
	root_markers = { ".git" },
	settings = {
		json = {
			schemas = require("schemastore").json.schemas({
				-- replace = {
				--     ["example.json"] = {
				--         description = "Example JSON schema",
				--         fileMatch = { "example.json" },
				--         name = 'example.json',
				--         url = 'https://example.com/example.json',
				--     }
				-- },
				extra = {
					{
						name = "vscode keybindings schema",
						description = "VSCode Keybindings Schema",
						fileMatch = { "keybindings.json" },
						url = vim.fn.expand(
							"~/.config/nvim/lua/core/lspconfig/jsonschema/vscode/keybindings.schema.json"
						),
					},
					{
						name = "Example",
						description = "Example JSON schema",
						fileMatch = { "example.json" },
						url = vim.fn.expand("~/.config/nvim/lua/core/lspconfig/jsonschema/example/product.schema.json"),
					},
					{
						name = "Turborepo",
						description = "Turborepo JSON schema",
						fileMatch = { "turbo.json" },
						url = vim.fn.expand("https://turborepo.dev/schema.json"),
					},
					{
						name = "Tsconfig",
						description = "Custom Tsconfig json",
						fileMatch = { "tsconfig.app.json" },
						url = vim.fn.expand("~/.config/nvim/lua/core/lspconfig/jsonschema/ts/tsconfig.schema.json"),
					},
				},
			}),
			format = {
				enable = true,
			},
			filetypes = { "json", "jsonc" },
			validate = { enable = true },
		},
	},
}
