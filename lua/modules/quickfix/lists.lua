local M = {}

function M.current()
	local info = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]
	local location = info and info.loclist == 1
	local fields = { id = 0, idx = 0, items = 0, context = 0, title = 0 }
	local list = location and vim.fn.getloclist(0, fields) or vim.fn.getqflist(fields)
	list.location = location
	return list
end

local function editable(list)
	if type(list.context) == "table" and list.context.aero_reading then
		vim.notify("Use :Aero reading edit to change a persisted reading list", vim.log.levels.INFO)
		return false
	end
	return true
end

local function replace(list, items, index)
	local opts = { items = items, idx = #items > 0 and math.max(1, math.min(index, #items)) or 0 }
	if list.id ~= 0 then
		opts.id = list.id
	end
	if list.location then
		vim.fn.setloclist(0, {}, "r", opts)
	else
		vim.fn.setqflist({}, "r", opts)
	end
end

function M.clear()
	local list = M.current()
	if not editable(list) then
		return false
	end
	replace(list, {}, 0)
	return true
end

function M.add()
	if vim.bo.buftype ~= "" or vim.api.nvim_buf_get_name(0) == "" then
		return vim.notify("Quickfix: select a named source buffer first", vim.log.levels.WARN)
	end
	local list = M.current()
	if not editable(list) then
		return
	end
	local cursor = vim.api.nvim_win_get_cursor(0)
	table.insert(list.items, {
		bufnr = vim.api.nvim_get_current_buf(),
		lnum = cursor[1],
		col = cursor[2] + 1,
		text = vim.api.nvim_get_current_line(),
	})
	replace(list, list.items, math.max(1, list.idx))
	vim.notify("Added to quickfix: " .. vim.api.nvim_get_current_line())
end

function M.delete(jump)
	local list = M.current()
	if not editable(list) then
		return false
	end
	local index = vim.bo.buftype == "quickfix" and vim.api.nvim_win_get_cursor(0)[1] or list.idx
	if not list.items[index] then
		return false
	end
	table.remove(list.items, index)
	replace(list, list.items, index)
	if jump and #list.items > 0 then
		local ok, err = pcall(vim.cmd, math.min(index, #list.items) .. (list.location and "ll" or "cc"))
		if not ok then
			vim.notify(err, vim.log.levels.WARN)
		end
	end
	return true
end

return M
