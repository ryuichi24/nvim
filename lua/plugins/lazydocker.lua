local logger = require("utils.logger"):new({ name = "plugins.lazydocker" })

logger:debug("Loading plugins.lazydocker...")

---@type BufferSession
local lazydocker_session = {
	buf = {
		id = nil,
	},
	win = {
		id = nil,
	},
}

local function open_floating_window(buffer)
	local editor_width = vim.o.columns
	local editor_height = vim.o.lines - vim.o.cmdheight

	local win_width = math.floor(editor_width * 0.95)
	local win_height = math.floor(editor_height * 0.95)

	local win_row = math.floor((editor_height - win_height) / 2)
	local win_col = math.floor((editor_width - win_width) / 2)

	return vim.api.nvim_open_win(buffer, true, {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = win_row,
		col = win_col,
		focusable = true,
		style = "minimal",
		border = "rounded",
	})
end

local function toggle_lazydocker()
	-- Close existing window
	if lazydocker_session.win.id and vim.api.nvim_win_is_valid(lazydocker_session.win.id) then
		vim.api.nvim_win_close(lazydocker_session.win.id, true)
		lazydocker_session.win.id = nil
		return
	end

	-- Reopen existing terminal
	if lazydocker_session.buf.id and vim.api.nvim_buf_is_valid(lazydocker_session.buf.id) then
		lazydocker_session.win.id = open_floating_window(lazydocker_session.buf.id)

		vim.schedule(function()
			vim.cmd.startinsert()
		end)

		return
	end

	-- Create terminal
	local buf = vim.api.nvim_create_buf(false, true)

	lazydocker_session.buf.id = buf
	lazydocker_session.win.id = open_floating_window(buf)

	vim.schedule(function()
		vim.fn.jobstart({ "lazydocker" }, {
			term = true,

			on_exit = function()
				vim.schedule(function()
					if lazydocker_session.win.id and vim.api.nvim_win_is_valid(lazydocker_session.win.id) then
						vim.api.nvim_win_close(lazydocker_session.win.id, true)
					end

					if lazydocker_session.buf.id and vim.api.nvim_buf_is_valid(lazydocker_session.buf.id) then
						vim.api.nvim_buf_delete(lazydocker_session.buf.id, { force = true })
					end

					lazydocker_session.win.id = nil
					lazydocker_session.buf.id = nil
				end)
			end,
		})

		vim.keymap.set("t", "<C-t>", toggle_lazydocker, {
			buffer = buf,
			silent = true,
			desc = "Close LazyDocker",
		})

		vim.cmd.startinsert()
	end)
end

vim.keymap.set("n", "<leader>ld", toggle_lazydocker, {
	silent = true,
	desc = "Toggle LazyDocker",
})
