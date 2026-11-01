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

-- Collapsed-fold background; customize for this theme.
vim.cmd.highlight("Folded guibg=#403D52")

-- Aero collapsed summaries, independent of expanded card headers.
local aero_folded_bg = "#403D52"
vim.api.nvim_set_hl(0, "AeroChatFolded", { bg = aero_folded_bg })
