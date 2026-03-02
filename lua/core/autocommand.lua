-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Automatically reload files changed outside of Neovim.
-- Enables 'autoread' and runs :checktime on focus, buffer enter,
-- or when the cursor is idle, so external changes are detected
-- without manual intervention.
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	command = "checktime",
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
