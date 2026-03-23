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

opts.desc = "Delete current item from quickfix list"
vim.keymap.set("n", "<leader>qd", function()
	local info = vim.fn.getqflist({ idx = 0 })
	local curqfidx = info.idx
	local qfall = vim.fn.getqflist()
	table.remove(qfall, curqfidx)
	vim.fn.setqflist(qfall, "r")
end, opts)

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		local buf_opts = { noremap = true, silent = true, buffer = true }
		buf_opts.desc = "Delete item under cursor from quickfix list"
		vim.keymap.set("n", "dd", function()
			local curqfidx = vim.fn.line(".")
			local qfall = vim.fn.getqflist()
			table.remove(qfall, curqfidx)
			vim.fn.setqflist(qfall, "r")
			vim.cmd("copen")
		end, buf_opts)
	end,
})
