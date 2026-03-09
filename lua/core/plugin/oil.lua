vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
})

local oil = require("oil")

oil.setup({
	default_file_explorer = true,
	keymaps = {
		-- Disable the default keymaps
		["<C-h>"] = false,
		["<C-l>"] = false,
		-- Custom oil keymaps
		["<C-n>"] = "actions.preview_scroll_down",
		["<C-p>"] = "actions.preview_scroll_up",
	},
})

-- keymap
vim.keymap.set("n", "-", function()
	oil.open()
end)

-- https://github.com/stevearc/oil.nvim/issues/87#issuecomment-2179322405
vim.api.nvim_create_autocmd("User", {
	pattern = "OilEnter",
	callback = vim.schedule_wrap(function(args)
		if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
			oil.open_preview({
				split = "belowright",
			})
		end
	end),
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "oil",
	callback = function()
		local opts = { buffer = true, remap = true }
	end,
})
