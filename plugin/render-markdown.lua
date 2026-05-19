-- https://github.com/MeanderingProgrammer/render-markdown.nvim/wiki
vim.pack.add({
	{
		name = "nvim-treesitter",
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
	{
		name = "nvim-web-devicons",
		src = "https://github.com/nvim-tree/nvim-web-devicons",
		version = "master",
	},
	{
		name = "render-markdown",
		src = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
		version = "main",
	},
})

local render_markdown = require("render-markdown")

render_markdown.setup({
	enabled = false,
	anti_conceal = { enabled = false },
	file_types = { "markdown" },
	render_modes = { "n", "c", "t", "i", "v" },
	padding = {
		highlight = "Normal",
	},
	heading = {
		sign = false,
		position = "overlay",
		width = "full",
		left_margin = 0,
		left_pad = 0,
		right_pad = 0,
		-- above = "▀",
		-- below = "▀",
		above = " ",
		below = " ",
		border = true,
		backgrounds = {
			"RenderMarkdownH1Bg",
			"RenderMarkdownH2Bg",
			"RenderMarkdownH3Bg",
			"RenderMarkdownH4Bg",
			"RenderMarkdownH5Bg",
			"RenderMarkdownH6Bg",
		},
		foregrounds = {
			"RenderMarkdownH1",
			"RenderMarkdownH2",
			"RenderMarkdownH3",
			"RenderMarkdownH4",
			"RenderMarkdownH5",
			"RenderMarkdownH6",
		},
		callout = {
			note = {
				raw = "[!note]",
				rendered = "󰋽 note",
				highlight = "rendermarkdowninfo",
				category = "github",
			},
			tip = {
				raw = "[!tip]",
				rendered = "󰌶 tip",
				highlight = "rendermarkdownsuccess",
				category = "github",
			},
			important = {
				raw = "[!important]",
				rendered = "󰅾 important",
				highlight = "rendermarkdownhint",
				category = "github",
			},
			warning = {
				raw = "[!warning]",
				rendered = "󰀪 warning",
				highlight = "rendermarkdownwarn",
				category = "github",
			},
			caution = {
				raw = "[!caution]",
				rendered = "󰳦 caution",
				highlight = "rendermarkdownerror",
				category = "github",
			},
			abstract = {
				raw = "[!abstract]",
				rendered = "󰨸 abstract",
				highlight = "rendermarkdowninfo",
				category = "obsidian",
			},
			summary = {
				raw = "[!summary]",
				rendered = "󰨸 summary",
				highlight = "rendermarkdowninfo",
				category = "obsidian",
			},
			tldr = {
				raw = "[!tldr]",
				rendered = "󰨸 tldr",
				highlight = "rendermarkdowninfo",
				category = "obsidian",
			},
			info = {
				raw = "[!info]",
				rendered = "󰋽 info",
				highlight = "rendermarkdowninfo",
				category = "obsidian",
			},
			todo = {
				raw = "[!todo]",
				rendered = "󰗡 todo",
				highlight = "rendermarkdowninfo",
				category = "obsidian",
			},
			hint = {
				raw = "[!hint]",
				rendered = "󰌶 hint",
				highlight = "rendermarkdownsuccess",
				category = "obsidian",
			},
			success = {
				raw = "[!success]",
				rendered = "󰄬 success",
				highlight = "rendermarkdownsuccess",
				category = "obsidian",
			},
			check = {
				raw = "[!check]",
				rendered = "󰄬 check",
				highlight = "rendermarkdownsuccess",
				category = "obsidian",
			},
			done = {
				raw = "[!done]",
				rendered = "󰄬 done",
				highlight = "rendermarkdownsuccess",
				category = "obsidian",
			},
			question = {
				raw = "[!question]",
				rendered = "󰘥 question",
				highlight = "rendermarkdownwarn",
				category = "obsidian",
			},
			help = {
				raw = "[!help]",
				rendered = "󰘥 help",
				highlight = "rendermarkdownwarn",
				category = "obsidian",
			},
			faq = {
				raw = "[!faq]",
				rendered = "󰘥 faq",
				highlight = "rendermarkdownwarn",
				category = "obsidian",
			},
			attention = {
				raw = "[!attention]",
				rendered = "󰀪 attention",
				highlight = "rendermarkdownwarn",
				category = "obsidian",
			},
			failure = {
				raw = "[!failure]",
				rendered = "󰅖 failure",
				highlight = "rendermarkdownerror",
				category = "obsidian",
			},
			fail = {
				raw = "[!fail]",
				rendered = "󰅖 fail",
				highlight = "rendermarkdownerror",
				category = "obsidian",
			},
			missing = {
				raw = "[!missing]",
				rendered = "󰅖 missing",
				highlight = "rendermarkdownerror",
				category = "obsidian",
			},
			danger = {
				raw = "[!danger]",
				rendered = "󱐌 danger",
				highlight = "rendermarkdownerror",
				category = "obsidian",
			},
			error = {
				raw = "[!error]",
				rendered = "󱐌 error",
				highlight = "rendermarkdownerror",
				category = "obsidian",
			},
			bug = {
				raw = "[!bug]",
				rendered = "󰨰 bug",
				highlight = "rendermarkdownerror",
				category = "obsidian",
			},
			example = {
				raw = "[!example]",
				rendered = "󰉹 example",
				highlight = "rendermarkdownhint",
				category = "obsidian",
			},
			quote = {
				raw = "[!quote]",
				rendered = "󱆨 quote",
				highlight = "rendermarkdownquote",
				category = "obsidian",
			},
			cite = {
				raw = "[!cite]",
				rendered = "󱆨 cite",
				highlight = "rendermarkdownquote",
				category = "obsidian",
			},
		},
	},
	code = {
		sign = false,
		language_icon = true,
		language_name = true,
		enabled = true,
		render_modes = false,
		conceal_delimiters = true,
		language = true,
		position = "left",
		language_info = true,
		language_pad = 0,
		disable = {},
		disable_background = { "diff" },
		width = "full",
		left_margin = 0,
		left_pad = 1,
		right_pad = 0,
		min_width = 0,
		border = "hide",
		language_border = "█",
		language_left = "",
		language_right = "",
		above = "▀",
		below = "▀",
		inline = true,
		inline_left = "",
		inline_right = "",
		inline_pad = 0,
		priority = 140,
		highlight = "RenderMarkdownCode",
		highlight_info = "RenderMarkdownCodeInfo",
		highlight_language = nil,
		highlight_border = "RenderMarkdownCodeBorder",
		highlight_fallback = "RenderMarkdownCodeFallback",
		highlight_inline = "RenderMarkdownCodeInline",
		style = "full",
	},
	quote = {
		highlight = "RenderMarkdownQuote",
	},
	link = {
		highlight = "RenderMarkdownLink",
	},
	table = {
		head = {
			"RenderMarkdownTableHead",
		},
		row = {
			"RenderMarkdownTableRow",
		},
	},
})

vim.api.nvim_create_autocmd("BufAdd", {
	pattern = "*.md",
	callback = function(evt)
		-- keymaps
		local opts = { buffer = evt.buf }
		vim.keymap.set("n", "<leader>mp", function()
			render_markdown.toggle()
		end, opts)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.md",
	callback = function(evt)
		-- color theme
		local opts = { bg = "#212830" }
		vim.api.nvim_set_hl(0, "Normal", opts)
		vim.api.nvim_set_hl(0, "NormalNC", opts)
		vim.api.nvim_set_hl(0, "EndOfBuffer", opts)

		vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#262c36" })

		vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", {
			fg = "#58a6ff",
			bg = "#161b22",
			bold = true,
		})
	end,
})

vim.api.nvim_create_autocmd("BufLeave", {
	pattern = "*.md",
	callback = function()
		local opts = { bg = "none" }
		vim.api.nvim_set_hl(0, "Normal", opts)
		vim.api.nvim_set_hl(0, "NormalNC", opts)
		vim.api.nvim_set_hl(0, "EndOfBuffer", opts)
	end,
})
