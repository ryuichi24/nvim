local logger = require("utils.logger"):new({ name = "theme.tokyonight" })

logger:debug("Loading theme.tokyonight...")

vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
})

local bg = "#011628"
local bg_dark = "#011423"
local bg_highlight = "#143652"
local bg_search = "#0A64AC"
local bg_visual = "#275378"
local fg = "#CBE0F0"
local fg_dark = "#B4D0E9"
local fg_gutter = "#627E97"
local border = "#547998"
local muted_blue = "#5c7cfa"

require("tokyonight").setup({
	style = "night",
	transparent = true,
	on_colors = function(colors)
		colors.bg = bg
		colors.bg_dark = bg_dark
		colors.bg_float = bg_dark
		colors.bg_highlight = bg_highlight
		colors.bg_popup = bg_dark
		colors.bg_search = bg_search
		colors.bg_sidebar = bg_dark
		colors.bg_statusline = bg_dark
		colors.bg_visual = bg_visual
		colors.border = border
		colors.fg = fg
		colors.fg_dark = fg_dark
		colors.fg_float = fg
		colors.fg_gutter = fg_gutter
		colors.fg_sidebar = fg_dark
	end,
})

-- load the colorscheme here
vim.cmd([[colorscheme tokyonight]])

vim.api.nvim_set_hl(0, "Folded", { fg = fg_dark, bg = bg_highlight, italic = true })

-- telescope
local function telescope_transparent()
	local hl = vim.api.nvim_set_hl
	local none = { bg = "none" }

	-- Main windows
	hl(0, "TelescopeNormal", none)
	hl(0, "TelescopeBorder", none)
	hl(0, "TelescopePromptNormal", none)
	hl(0, "TelescopePromptBorder", none)
	hl(0, "TelescopeResultsNormal", none)
	hl(0, "TelescopeResultsBorder", none)
	hl(0, "TelescopePreviewNormal", none)
	hl(0, "TelescopePreviewBorder", none)

	-- Title areas
	hl(0, "TelescopePromptTitle", none)
	hl(0, "TelescopeResultsTitle", none)
	hl(0, "TelescopePreviewTitle", none)
end

telescope_transparent()

-- tree
local function nvim_tree_transparent()
	local hl = vim.api.nvim_set_hl
	local none = { bg = "none" }

	hl(0, "NvimTreeNormal", none)
	hl(0, "NvimTreeNormalNC", none)
	hl(0, "NvimTreeEndOfBuffer", none)
	hl(0, "NvimTreeVertSplit", none)
	hl(0, "NvimTreeWinSeparator", none)
	hl(0, "NvimTreeStatusLine", none)
end

nvim_tree_transparent()

vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {
	fg = muted_blue,
	italic = true,
})
