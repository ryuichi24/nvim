---@type BufferSession
local lazygit_session = {
	buf = {
		id = nil,
	},
	win = {
		id = nil,
		width = nil,
		height = nil,
	},
}

local function open_floating_window(buffer)
	local editor_width = vim.o.columns
	local editor_height = vim.o.lines - vim.o.cmdheight
	-- window size
	local win_width = math.floor(editor_width * 0.95)
	local win_height = math.floor(editor_height * 0.95)
	-- window coordinates
	local win_row = math.floor((editor_height - win_height) / 2)
	local win_col = math.floor((editor_width - win_width) / 2)

	local new_win_id = vim.api.nvim_open_win(buffer, true, {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = win_row,
		col = win_col,
		focusable = true,
		external = false,
		style = "minimal",
		border = "rounded",
		noautocmd = true,
	})

	return new_win_id
end

local function toggle_lazygit()
	if lazygit_session.win.id and vim.api.nvim_win_is_valid(lazygit_session.win.id) then
		vim.api.nvim_win_close(lazygit_session.win.id, true)
		lazygit_session.win.id = nil
		return
	end

	if lazygit_session.buf.id and vim.api.nvim_buf_is_valid(lazygit_session.buf.id) then
		lazygit_session.win.id = open_floating_window(lazygit_session.buf.id)
	else
		local shouldBeListed, shouldBeTempBuf = false, true
		lazygit_session.buf.id = vim.api.nvim_create_buf(shouldBeListed, shouldBeTempBuf)
		lazygit_session.win.id = open_floating_window(lazygit_session.buf.id)

		vim.schedule(function()
			vim.fn.jobstart({ "lazygit" }, {
				term = true,
				on_exit = function()
					if lazygit_session.win.id and vim.api.nvim_win_is_valid(lazygit_session.win.id) then
						vim.api.nvim_win_close(lazygit_session.win.id, true)
						lazygit_session.win.id = nil
					end
					if lazygit_session.buf.id and vim.api.nvim_buf_is_valid(lazygit_session.buf.id) then
						vim.api.nvim_buf_delete(lazygit_session.buf.id, { force = true })
						lazygit_session.buf.id = nil
					end
				end,
			})

			local map = vim.keymap.set
			---@type vim.keymap.set.Opts
			local opts = { buffer = lazygit_session.buf.id, silent = true, noremap = true }

			map("t", "<C-t>", toggle_lazygit, opts)
		end)
	end

	vim.cmd.startinsert()
end

local map = vim.keymap.set
---@type vim.keymap.set.Opts
local opts = { silent = true, noremap = true }

opts.desc = "Toggle Lazygit"
map("n", "<leader>lg", toggle_lazygit, opts)
