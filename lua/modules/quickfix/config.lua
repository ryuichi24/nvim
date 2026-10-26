local M = {}
local lists = require("modules.quickfix.lists")

function M.setup()
	local function map(lhs, rhs, desc, buffer)
		vim.keymap.set("n", lhs, rhs, { silent = true, desc = desc, buffer = buffer })
	end
	map("<C-t>", "<cmd>cprev<CR>", "Go to previous quickfix item")
	map("<C-g>", "<cmd>cnext<CR>", "Go to next quickfix item")
	map("<leader>qq", function()
		if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
			vim.cmd.cclose()
		else
			vim.cmd.copen()
		end
	end, "Toggle quickfix window")
	map("<leader>qQ", function()
		vim.cmd.cclose()
	end, "Close quickfix window")
	map("<leader>qc", function()
		local location = lists.current().location
		if lists.clear() then
			if location then
				vim.cmd.lclose()
			else
				vim.cmd.cclose()
			end
		end
	end, "Clear quickfix list")
	map("<leader>qa", lists.add, "Add current line to quickfix list")
	map("<leader>qd", function()
		lists.delete(true)
	end, "Delete selected quickfix item")

	local group = vim.api.nvim_create_augroup("QuickfixModule", { clear = true })
	local function attach(buf)
		map("dd", function()
			lists.delete()
		end, "Delete quickfix item under cursor", buf)
		map("<CR>", function()
			local index = vim.api.nvim_win_get_cursor(0)[1]
			local list = lists.current()
			-- :cc/:ll use the quickfix window's associated file window.
			local ok, err = pcall(vim.cmd, index .. (list.location and "ll" or "cc"))
			if not ok then
				vim.notify(err, vim.log.levels.WARN)
			end
		end, "Open quickfix item", buf)
	end
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = "qf",
		callback = function(args)
			attach(args.buf)
		end,
	})
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].filetype == "qf" then
			attach(buf)
		end
	end
end

return M
