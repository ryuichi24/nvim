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

-- Collapsed-fold background; customize for this theme.
vim.cmd.highlight("Folded guibg=#45475A")

-- Aero collapsed summaries, independent of expanded card headers.
local aero_folded_bg = "#45475A"
vim.api.nvim_set_hl(0, "AeroChatFolded", { bg = aero_folded_bg })
