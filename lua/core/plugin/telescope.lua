vim.pack.add({
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		path_display = { "smart" },
		-- default mappings: https://github1s.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua#L135-L232
		mappings = {
			i = {
				["<LeftMouse>"] = {
					actions.mouse_click,
					type = "action",
					opts = { expr = true },
				},
				["<2-LeftMouse>"] = {
					actions.double_mouse_click,
					type = "action",
					opts = { expr = true },
				},

				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,

				["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<C-f>"] = actions.preview_scrolling_left,
				["<C-k>"] = actions.preview_scrolling_right,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["<M-f>"] = actions.results_scrolling_left,
				["<M-k>"] = actions.results_scrolling_right,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-/>"] = actions.which_key,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
				["<C-w>"] = { "<c-s-w>", type = "command" },
				["<C-r><C-w>"] = actions.insert_original_cword,
				["<C-r><C-a>"] = actions.insert_original_cWORD,
				["<C-r><C-f>"] = actions.insert_original_cfile,
				["<C-r><C-l>"] = actions.insert_original_cline,

				-- disable c-j because we dont want to allow new lines #2123
				["<C-j>"] = actions.nop,
			},
			n = {
				["<LeftMouse>"] = {
					actions.mouse_click,
					type = "action",
					opts = { expr = true },
				},
				["<2-LeftMouse>"] = {
					actions.double_mouse_click,
					type = "action",
					opts = { expr = true },
				},

				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				-- TODO: This would be weird if we switch the ordering.
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,
				["<C-f>"] = actions.preview_scrolling_left,
				["<C-k>"] = actions.preview_scrolling_right,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["<M-f>"] = actions.results_scrolling_left,
				["<M-k>"] = actions.results_scrolling_right,

				["?"] = actions.which_key,
			},
		},
	},
	pickers = {
		find_files = {
			-- themes: https://github1s.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/themes.lua#L108
			theme = "ivy",
			-- theme = "cursor",
			-- theme = "dropdown",
			hidden = true,
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
		},
	},
})

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Find recent files" })
vim.keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fm", function()
	require("telescope.builtin").marks()
end, { desc = "Find marks (Telescope)" })

vim.keymap.set("n", "<leader>fc", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.stdpath("config"),
	})
end, { desc = "Find files in neovim config dir" })
