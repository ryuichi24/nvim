---@type vim.keymap.set.Opts
local opts = { noremap = true, silent = true }

opts.desc = "Open quickfix window"
vim.keymap.set("n", "<C-[>", ":cprev<CR>", opts)

opts.desc = "Go to next error"
vim.keymap.set("n", "<C-]>", ":cnext<CR>", opts)

opts.desc = "Open quickfix window"
vim.keymap.set("n", "<leader>qq", ":copen<CR>", opts)

opts.desc = "Close quickfix window"
vim.keymap.set("n", "<leader>QQ", ":cclose<CR>", opts)

opts.desc = "Clear quickfix list"
vim.keymap.set("n", "<leader>qc", function()
	vim.fn.setqflist({})
end, opts)

opts.desc = "Add current line to quickfix list"
vim.keymap.set("n", "<leader>qa", function()
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	local bufnr = vim.fn.bufnr()
	local filename = vim.fn.expand("%:p")
	local text = vim.fn.getline(".")

	local qflist = vim.fn.getqflist()
	table.insert(qflist, {
		bufnr = bufnr,
		filename = filename,
		lnum = line,
		col = col,
		text = text,
	})
	vim.fn.setqflist(qflist)
	print("Added to quickfix: " .. text)
end, opts)
