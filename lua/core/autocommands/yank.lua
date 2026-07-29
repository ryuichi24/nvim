local logger = require("utils.logger"):new({ name = "autocommands.yank" })

logger:debug("Loading autocommands.yank...")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
