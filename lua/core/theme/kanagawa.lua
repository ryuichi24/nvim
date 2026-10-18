local logger = require("utils.logger"):new({ name = "theme.kanagawa" })

logger:debug("Loading theme.kanagawa...")

vim.pack.add({
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
})

require("kanagawa").setup({
	theme = "wave",
	transparent = false,
	commentStyle = { italic = true },
	keywordStyle = { italic = false },
})

vim.o.background = "dark"
vim.cmd.colorscheme("kanagawa-wave")
