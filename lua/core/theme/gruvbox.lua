local logger = require("utils.logger"):new({ name = "theme.gruvbox" })

logger:debug("Loading theme.gruvbox...")

vim.pack.add({
	{ src = "https://github.com/ellisonleao/gruvbox.nvim" },
})

require("gruvbox").setup({
	contrast = "hard",
	transparent_mode = false,
	italic = {
		comments = true,
		strings = false,
		operators = false,
		folds = true,
	},
})

vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")
