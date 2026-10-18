local logger = require("utils.logger"):new({ name = "theme.graphite" })

logger:debug("Loading theme.graphite...")

vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
})

-- Graphite palette, using TokyoNight's syntax and plugin integrations.
require("tokyonight").setup({
	style = "night",
	transparent = false,
	styles = {
		comments = { italic = true },
		keywords = { italic = false },
	},
	on_colors = function(colors)
		colors.bg = "#181818"
		colors.bg_dark = "#141414"
		colors.bg_dark1 = "#111111"
		colors.bg_float = "#202020"
		colors.bg_highlight = "#2A2A2A"
		colors.bg_popup = "#202020"
		colors.bg_search = "#48412B"
		colors.bg_sidebar = "#141414"
		colors.bg_statusline = "#141414"
		colors.bg_visual = "#343434"
		colors.border = "#383838"
		colors.border_highlight = "#606060"
		colors.fg = "#D4D4D4"
		colors.fg_dark = "#A0A0A0"
		colors.fg_float = "#D4D4D4"
		colors.fg_gutter = "#505050"
		colors.fg_sidebar = "#A0A0A0"
		colors.comment = "#727272"
		colors.dark3 = "#606060"
		colors.dark5 = "#808080"
		colors.blue = "#87B8D5"
		colors.blue0 = "#6A9FC0"
		colors.blue1 = "#87B8D5"
		colors.blue2 = "#9CCFD8"
		colors.blue5 = "#87B8D5"
		colors.blue6 = "#9CCFD8"
		colors.blue7 = "#354A57"
		colors.cyan = "#9CCFD8"
		colors.green = "#A8C78C"
		colors.green1 = "#A8C78C"
		colors.green2 = "#8FAF87"
		colors.magenta = "#C4A7D7"
		colors.magenta2 = "#C4A7D7"
		colors.orange = "#D9A780"
		colors.purple = "#C4A7D7"
		colors.red = "#E08A8A"
		colors.red1 = "#E08A8A"
		colors.teal = "#8FBCBB"
		colors.yellow = "#D8C38D"
		colors.error = colors.red
		colors.warning = colors.yellow
		colors.info = colors.blue
		colors.hint = colors.teal
		colors.git = { add = "#81A873", change = "#87B8D5", delete = "#E08A8A" }
		colors.diff = { add = "#233025", change = "#242D35", delete = "#362525", text = "#354553" }
	end,
	on_highlights = function(hl, colors)
		hl.Folded = { fg = colors.fg_dark, bg = colors.bg_highlight, italic = true }
		hl.DiagnosticUnnecessary = { fg = colors.comment, italic = true }
	end,
})

vim.cmd.colorscheme("tokyonight")
