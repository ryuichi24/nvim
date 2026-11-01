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

-- Collapsed-fold background; customize for this theme.
vim.cmd.highlight("Folded guibg=#2D4F67")

-- Aero collapsed summaries, independent of expanded card headers.
local aero_folded_bg = "#2D4F67"
vim.api.nvim_set_hl(0, "AeroChatFolded", { bg = aero_folded_bg })
