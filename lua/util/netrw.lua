-- netwr config
vim.g.netrw_keepdir = 1
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 0

vim.g.netrw_preview = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 30

vim.keymap.set("n", "<leader>ee", vim.cmd.Ex)
vim.keymap.set("n", "-", vim.cmd.Ex)

-- Disable "go up directory"
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		local opts = {
			buffer = true,
			-- it recursively calls the keymap
			remap = true,
		}

		vim.keymap.set("n", "-", "<Nop>", opts)
		vim.keymap.set("n", "l", "<CR>", opts)

		-- create a new file
		vim.keymap.set("n", "a", function()
			vim.cmd("normal %")
			vim.cmd("write")
			vim.cmd.Ex()
		end, { buffer = true })

		-- rename a file
		vim.keymap.set("n", "r", "R", opts)
	end,
})

-- preview config
vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved" }, {
	callback = function()
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			if vim.wo[win].previewwindow then
				vim.api.nvim_win_close(win, true)
			end
		end
	end,
})
