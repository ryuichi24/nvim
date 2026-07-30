local logger = require("utils.logger"):new({ name = "keymap.wrap" })

logger:debug("Loading keymap.wrap...")

-- Wrap selected texts
vim.keymap.set("v", "<leader>w(", 'c(<C-r>")<ESC>', { silent = true })
vim.keymap.set("v", "<leader>w[", 'c[<C-r>"]<ESC>', { silent = true })
vim.keymap.set("v", "<leader>w{", 'c{<C-r>"}<ESC>', { silent = true })
vim.keymap.set("v", '<leader>w"', 'c"<C-r>""<ESC>', { silent = true })
vim.keymap.set("v", "<leader>w'", "c'<C-r>\"'<ESC>", { silent = true })
vim.keymap.set("v", "<leader>w`", 'c`<C-r>"`<ESC>', { silent = true })
vim.keymap.set("v", "<leader>wt", function()
	local tag = vim.fn.input("Tag: ")

	local keys = "c<" .. tag .. ">" .. vim.api.nvim_replace_termcodes('<C-r>"', true, false, true) .. "</" .. tag .. ">"

	vim.api.nvim_feedkeys(keys, "n", false)
end, { silent = true })
