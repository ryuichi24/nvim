local logger = require("utils.logger"):new({ name = "theme.rosepine" })

logger:debug("Loading theme.rosepine...")

vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
})

require("rose-pine").setup({
	variant = "main",
	styles = {
		bold = true,
		italic = true,
		transparency = false,
	},
})

vim.o.background = "dark"
vim.cmd.colorscheme("rose-pine-main")
