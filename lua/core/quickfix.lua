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

-- Preview state sared across the quickfix buffer lifecycle
local preview = {
	win = nil, -- floating window id
	enabled = true, -- whether preview is active
}

--- Safely close the preview floating window
local function close_preview()
	if preview.win and vim.api.nvim_win_is_valid(preview.win) then
		vim.api.nvim_win_close(preview.win, true)
	end
	preview.win = nil
end

--- Show a floating preview for the quickfix entry under the cursor
local function show_preview()
	if not preview.enabled then
		return
	end

	-- Only show preview when the current window is actually a quickfix window
	if vim.bo.buftype ~= "quickfix" then
		return
	end

	local cursor_line = vim.fn.line(".")
	local qflist = vim.fn.getqflist()
	local entry = qflist[cursor_line]

	if not entry or entry.bufnr == 0 then
		close_preview()
		return
	end

	-- Ensure the buffer is loaded so we can display its contents
	if not vim.api.nvim_buf_is_loaded(entry.bufnr) then
		vim.fn.bufload(entry.bufnr)
	end

	-- Ensure filetype is detected so treesitter highlighting attaches.
	-- bufload() does not fire FileType autocommands, so we must detect manually.
	if vim.bo[entry.bufnr].filetype == "" then
		local ft = vim.filetype.match({ buf = entry.bufnr })
		if ft then
			vim.bo[entry.bufnr].filetype = ft
		end
	end

	-- Calculate floating window dimensions relative to the editor
	local editor_width = vim.o.columns
	local editor_height = vim.o.lines - vim.o.cmdheight - 1 -- subtract statusline/cmdline

	local win_width = math.floor(editor_width * 0.6)
	local win_height = math.floor(editor_height * 0.6)
	local row = math.floor((editor_height - win_height) / 2)
	local col = math.floor((editor_width - win_width) / 2)

	local float_opts = {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		focusable = false, -- keep focus in the quickfix window
	}

	-- Reuse existing window or create a new one
	if preview.win and vim.api.nvim_win_is_valid(preview.win) then
		vim.api.nvim_win_set_buf(preview.win, entry.bufnr)
		vim.api.nvim_win_set_config(preview.win, float_opts)
	else
		preview.win = vim.api.nvim_open_win(entry.bufnr, false, float_opts)
	end

	-- Configure the preview window appearance
	vim.api.nvim_set_option_value("cursorline", true, { win = preview.win })
	vim.api.nvim_set_option_value("number", true, { win = preview.win })
	vim.api.nvim_set_option_value("relativenumber", false, { win = preview.win })
	vim.api.nvim_set_option_value("signcolumn", "no", { win = preview.win })
	vim.api.nvim_set_option_value("winhighlight", "CursorLine:Visual", { win = preview.win })

	-- Jump to the target line and center it in the preview
	local target_line = math.max(1, entry.lnum)
	local line_count = vim.api.nvim_buf_line_count(entry.bufnr)
	target_line = math.min(target_line, line_count)

	vim.api.nvim_win_set_cursor(preview.win, { target_line, math.max(0, (entry.col or 1) - 1) })

	-- Center the target line in the preview window by adjusting the viewport
	local half_height = math.floor(win_height / 2)
	local topline = math.max(1, target_line - half_height)
	vim.api.nvim_win_call(preview.win, function()
		vim.fn.winrestview({ topline = topline })
	end)
end

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

		buf_opts.desc = "Open quickfix item in main window"
		vim.keymap.set("n", "<CR>", function()
			local cursor_line = vim.fn.line(".")
			close_preview()
			-- Jump to the previous (main) window, then use :cc to open the entry there
			vim.cmd("wincmd p")
			vim.cmd(cursor_line .. "cc")
		end, buf_opts)

		-- Preview: toggle with 'p'
		buf_opts.desc = "Toggle quickfix preview window"
		vim.keymap.set("n", "p", function()
			preview.enabled = not preview.enabled
			if preview.enabled then
				show_preview()
				vim.notify("Quickfix preview: ON", vim.log.levels.INFO)
			else
				close_preview()
				vim.notify("Quickfix preview: OFF", vim.log.levels.INFO)
			end
		end, buf_opts)

		-- Show preview on cursor movement
		local qf_buf = vim.api.nvim_get_current_buf()
		local preview_group = vim.api.nvim_create_augroup("QuickfixPreview", { clear = true })

		vim.api.nvim_create_autocmd("CursorMoved", {
			group = preview_group,
			buffer = qf_buf,
			callback = show_preview,
		})

		-- Close preview when leaving the quickfix window
		vim.api.nvim_create_autocmd("BufLeave", {
			group = preview_group,
			buffer = qf_buf,
			callback = close_preview,
		})

		-- Also close if the quickfix window itself is closed
		vim.api.nvim_create_autocmd("WinClosed", {
			group = preview_group,
			callback = function()
				if not vim.api.nvim_buf_is_valid(qf_buf) then
					close_preview()
					return true -- delete this autocmd
				end
			end,
		})
	end,
})

-- to replace across all quickfix items
-- :cfdo s/<pattern>/<replacement>/g | update

-- to replace across all quickfix items with confirmation
-- :cfdo s/<pattern>/<replacement>/gc | update
