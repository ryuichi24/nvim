---@type vim.keymap.set.Opts
local opts = { noremap = true, silent = true }

opts.desc = "Go to previous quickfix item"
vim.keymap.set("n", "<C-t>", ":cprev<CR>", opts)

opts.desc = "Go to next quickfix item"
vim.keymap.set("n", "<C-g>", ":cnext<CR>", opts)

opts.desc = "Open quickfix window"
vim.keymap.set("n", "<leader>qq", ":copen<CR>", opts)

opts.desc = "Close quickfix window"
vim.keymap.set("n", "<leader>QQ", ":cclose<CR>", opts)

opts.desc = "Clear quickfix list"
vim.keymap.set("n", "<leader>qc", function()
	vim.fn.setqflist({})
	vim.cmd("cclose")
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

opts.desc = "Delete selected quickfix item (from anywhere)"
vim.keymap.set("n", "<leader>qd", function()
	local info = vim.fn.getqflist({ idx = 0 })
	local curqfidx = info.idx
	local qfall = vim.fn.getqflist()
	table.remove(qfall, curqfidx)
	vim.fn.setqflist(qfall, "r")
	local next_idx = math.min(curqfidx, #vim.fn.getqflist())
	if next_idx > 0 then
		vim.cmd(next_idx .. "cc")
	end
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

-- to replace across all quickfix items
-- :cfdo s/<pattern>/<replacement>/g | update

-- to replace across all quickfix items with confirmation
-- :cfdo s/<pattern>/<replacement>/gc | update
