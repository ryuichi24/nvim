--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/sourcekit.lua
---@brief
---
--- https://github.com/swiftlang/sourcekit-lsp
---
--- Language server for Swift and C/C++/Objective-C.

---@type vim.lsp.Config
return {
	cmd = { "sourcekit-lsp" },
	filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
	root_dir = function(bufnr, on_dir)
		local filename = vim.api.nvim_buf_get_name(bufnr)

		local root = vim.fs.root(filename, { "buildServer.json", ".bsp" })
			or vim.fs.root(filename, { "*.xcodeproj", "*.xcworkspace" })
			-- keep at the end: some projects have multiple Package.swift files
			or vim.fs.root(filename, { "compile_commands.json", "Package.swift" })
			or vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true })[1])

		on_dir(root)
	end,

	get_language_id = function(_, ftype)
		local map = {
			objc = "objective-c",
			objcpp = "objective-cpp",
		}
		return map[ftype] or ftype
	end,

	capabilities = {
		workspace = {
			didChangeWatchedFiles = { dynamicRegistration = true },
		},
		textDocument = {
			diagnostic = {
				dynamicRegistration = true,
				relatedDocumentSupport = true,
			},
		},
	},
}
