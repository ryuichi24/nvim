---@brief
--- Install with `:MasonInstall vue-language-server`.
--- TypeScript support is provided by vtsls and @vue/typescript-plugin.
--- The tsserver request handler is inherited from nvim-lspconfig.

---@type vim.lsp.Config
return {
	cmd = { "vue-language-server", "--stdio" },
	filetypes = { "vue" },
	root_markers = { "package.json" },
}
