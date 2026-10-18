local logger = require("utils.logger"):new({ name = "theme.catppuccin" })

logger:debug("Loading theme.catppuccin...")

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = false,
	styles = {
		comments = { "italic" },
	},
	integrations = {
		nvimtree = true,
		telescope = { enabled = true },
		treesitter = true,
	},
})

vim.cmd.colorscheme("catppuccin")
