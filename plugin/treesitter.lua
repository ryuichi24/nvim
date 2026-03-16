vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
})

-- import nvim-treesitter plugin
local treesitter = require("nvim-treesitter.configs")

-- configure treesitter
treesitter.setup({
	sync_install = false,
	ignore_install = {},
	modules = {},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	ensure_installed = {
		"vim",
		"vimdoc",
		"bash",
		"lua",
		"go",
		"json",
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"c",
		"cpp",
		"python",
		"markdown",
		"markdown_inline",
		"yaml",
		"dockerfile",
		"gitignore",
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
	callback = function(evt)
		local package_name, evt_type = evt.data.spec.name, evt.data.kind
		if evt_type == "update" and package_name == "nvim-treesitter" then
			vim.notify("nvim-treesitter updated, running TSUpdate...", vim.log.levels.INFO)
			local ok = pcall(vim.cmd, "TSUpdate")
			if ok then
				vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
			else
				vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.INFO)
			end
		end
	end,
})
