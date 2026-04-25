vim.pack.add({
	{
		name = "nvim-treesitter",
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
})

local treesitter = require("nvim-treesitter")

treesitter.setup({
	install_dir = vim.fn.stdpath("data") .. "/treesitter",
})

treesitter.install({
	"lua",
	"javascript",
	"typescript",
	"tsx",
	"go",
	"c",
	"cpp",
	"markdown",
	"json",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua", "javascript", "typescript", "typescriptreact", "go", "c", "cpp", "markdown", "json" },
	callback = function()
		vim.treesitter.start()
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
	callback = function(evt)
		local package_name, evt_type = evt.data.spec.name, evt.data.kind
		if evt_type == "update" and package_name == "nvim-treesitter" then
			vim.notify("nvim-treesitter updated, running TSUpdate...", vim.log.levels.INFO)
			vim.cmd("TSUpdate")
		end
	end,
})
