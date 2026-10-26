local M = {}
local api = vim.api
local state = { enabled = true, generation = 0 }
local max_bytes = 2 * 1024 * 1024

function M.close()
	state.generation = state.generation + 1
	local win, buf = state.win, state.buf
	state.win, state.buf, state.owner = nil, nil, nil
	if win and api.nvim_win_is_valid(win) then
		api.nvim_win_close(win, true)
	end
	if buf and api.nvim_buf_is_valid(buf) then
		api.nvim_buf_delete(buf, { force = true })
	end
end

function M.window_closed(win)
	if win == state.owner or win == state.win then
		M.close()
	end
end

local function contents(entry)
	if not entry or not entry.bufnr or entry.bufnr == 0 or not api.nvim_buf_is_valid(entry.bufnr) then
		return
	end
	local path = api.nvim_buf_get_name(entry.bufnr)
	if api.nvim_buf_is_loaded(entry.bufnr) then
		if api.nvim_buf_get_offset(entry.bufnr, api.nvim_buf_line_count(entry.bufnr)) > max_bytes then
			return { "Preview omitted: buffer exceeds 2 MiB." }, path, true
		end
		return api.nvim_buf_get_lines(entry.bufnr, 0, -1, false), path
	end
	local stat = vim.uv.fs_stat(path)
	if not stat or stat.type ~= "file" then
		return
	end
	if stat.size > max_bytes then
		return { "Preview omitted: file exceeds 2 MiB." }, path, true
	end
	local ok, lines = pcall(vim.fn.readfile, path)
	if ok then
		return #lines > 0 and lines or { "" }, path
	end
end

function M.show()
	if not state.enabled or vim.bo.buftype ~= "quickfix" then
		return
	end
	local owner = api.nvim_get_current_win()
	local list = require("modules.quickfix.lists").current()
	local entry = list.items[api.nvim_win_get_cursor(owner)[1]]
	local lines, path, omitted = contents(entry)
	if not lines then
		return M.close()
	end
	local width = math.min(math.max(1, math.floor(vim.o.columns * 0.6)), math.max(1, vim.o.columns - 4))
	local available = math.max(1, vim.o.lines - vim.o.cmdheight - 4)
	local height = math.min(math.max(1, math.floor(available * 0.6)), available)
	local options = {
		relative = "editor",
		width = width,
		height = height,
		row = math.max(0, math.floor((available - height) / 2)),
		col = math.max(0, math.floor((vim.o.columns - width) / 2)),
		style = "minimal",
		border = "rounded",
		focusable = false,
		title = " " .. vim.fs.basename(path) .. ":" .. math.max(1, entry.lnum or 1) .. " ",
	}
	if not state.buf or not api.nvim_buf_is_valid(state.buf) then
		state.buf = api.nvim_create_buf(false, true)
		vim.bo[state.buf].bufhidden = "wipe"
		vim.bo[state.buf].swapfile = false
	end
	local buf = state.buf
	pcall(vim.treesitter.stop, buf)
	vim.bo[buf].modifiable = true
	api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].modified = false
	-- Deliberately leave filetype empty: FileType hooks would start LSP clients.
	-- Tree-sitter can highlight the scratch buffer without those hooks.
	if not omitted then
		local ft = vim.filetype.match({ filename = path, contents = lines })
		local lang = ft and vim.treesitter.language.get_lang(ft)
		if lang then
			pcall(vim.treesitter.start, buf, lang)
		end
	end
	if state.win and api.nvim_win_is_valid(state.win) then
		api.nvim_win_set_config(state.win, options)
	else
		state.win = api.nvim_open_win(buf, false, options)
	end
	state.owner = owner
	local win = state.win
	vim.wo[win].cursorline = true
	vim.wo[win].number = not omitted
	vim.wo[win].relativenumber = false
	vim.wo[win].signcolumn = "no"
	vim.wo[win].wrap = false
	vim.wo[win].winhighlight = "CursorLine:Visual"
	local line = omitted and 1 or math.min(math.max(1, entry.lnum or 1), #lines)
	local col = math.min(math.max(0, (entry.col or 1) - 1), #(lines[line] or ""))
	api.nvim_win_set_cursor(win, { line, col })
	api.nvim_win_call(win, function()
		vim.cmd("normal! zz")
	end)
end

function M.schedule()
	state.generation = state.generation + 1
	local generation, owner = state.generation, api.nvim_get_current_win()
	vim.defer_fn(function()
		if generation == state.generation and api.nvim_win_is_valid(owner) and api.nvim_get_current_win() == owner then
			M.show()
		end
	end, 80)
end

function M.toggle()
	state.enabled = not state.enabled
	if state.enabled then
		M.show()
	else
		M.close()
	end
	vim.notify("Quickfix preview: " .. (state.enabled and "ON" or "OFF"))
end

return M
