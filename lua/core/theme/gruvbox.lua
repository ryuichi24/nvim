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

-- Collapsed-fold background; customize for this theme.
vim.cmd.highlight("Folded guibg=#504945")

-- Aero collapsed summaries, independent of expanded card headers.
local aero_folded_bg = "#504945"
vim.api.nvim_set_hl(0, "AeroChatFolded", { bg = aero_folded_bg })
