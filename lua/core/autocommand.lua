-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Automatically reload files changed outside of Neovim
vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	callback = function()
		local mode = vim.fn.mode()
		if vim.bo.buftype == "" and mode ~= "c" and mode ~= "r" then
			vim.cmd("checktime")
		end
	end,
})

-- Create an augroup for help buffers
local help_group = vim.api.nvim_create_augroup("custom-help-buffer", { clear = true })

-- Create autocmd for help filetype
vim.api.nvim_create_autocmd("FileType", {
	group = help_group,
	pattern = "help",
	callback = function()
		vim.cmd("only") -- close all other windows
	end,
})
