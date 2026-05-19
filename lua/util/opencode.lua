---@param buf number
---@param opts { location: "left" | "right" | "top" | "bottom", size: { width: number, height: number } }
---@return number
local function open_buffer_in_new_win(buf, opts)
	if opts.location == "left" then
		vim.cmd("leftabove vsplit")
	elseif opts.location == "right" then
		vim.cmd("rightbelow vsplit")
	elseif opts.location == "top" then
		vim.cmd("topleft split")
	elseif opts.location == "bottom" then
		vim.cmd("botright split")
	end

	local new_win = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_buf(new_win, buf)
	vim.api.nvim_win_set_width(new_win, opts.size.width)
	return new_win
end

---@class TuiApp
---@field name string
---@field cmd string[]

---@class Win
---@field id number | nil
---@field width number | nil

---@class TerminalSession
---@field buf { id: number | nil, channel: number | nil }
---@field win Win | nil
---@field app TuiApp | nil
local open_code_session = {
	buf = {
		id = nil,
		channel = nil,
	},
	win = {
		id = nil,
		width = math.floor(vim.o.columns * 0.3),
	},
	app = {
		name = "opencode",
		cmd = { "opencode", "." },
	},
}

---@param session TerminalSession
local function toggle_opencode(session)
	-- close existing window if exists
	if session.win.id and vim.api.nvim_win_is_valid(session.win.id) then
		vim.api.nvim_win_close(session.win.id, true)
		session.win.id = nil
		return
	end

	-- open existing buffer with new window if exists
	if session.buf.id ~= nil and vim.api.nvim_buf_is_valid(session.buf.id) then
		session.win.id =
			open_buffer_in_new_win(session.buf.id, { location = "right", size = { width = session.win.width } })
	else
		-- create new buffer and window
		local shouldBeListed, shouldBeTempBuf = false, true
		session.buf.id = vim.api.nvim_create_buf(shouldBeListed, shouldBeTempBuf)
		session.buf.channel = vim.bo.channel
		print("creating new buffer with channel: ", session.buf.channel)
		session.win.id =
			open_buffer_in_new_win(session.buf.id, { location = "right", size = { width = session.win.width } })

		-- start tui app
		vim.schedule(function()
			local channel_id
			vim.fn.jobstart(session.app.cmd, {
				term = true,
				on_exit = function()
					if session.win.id and vim.api.nvim_win_is_valid(session.win.id) then
						vim.api.nvim_win_close(session.win.id, true)
						session.win.id = nil
					end
					if session.buf.id and vim.api.nvim_buf_is_valid(session.buf.id) then
						vim.api.nvim_buf_delete(session.buf.id, { force = true })
						session.buf.id = nil
						session.buf.channel = nil
					end
				end,
			})
			session.buf.channel = channel_id
		end)
	end

	vim.cmd.startinsert()
end

local group = vim.api.nvim_create_augroup("opencode.cmd.group", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	group = group,
	pattern = "term://*/opencode",
	callback = function(evt)
		local opts = { buffer = evt.buf, desc = "Exit terminal mode with jj." }

		opts.desc = "Exit terminal mode with jj."
		vim.keymap.set("t", "jj", [[<C-\><C-n>]], opts)

		vim.keymap.set("t", "<C-t>", function()
			toggle_opencode(open_code_session)
		end, opts)
	end,
})

vim.keymap.set("n", "<leader>oc", function()
	toggle_opencode(open_code_session)
end, { desc = "Toggle opencode" })

vim.keymap.set("v", "<leader>os", function()
	-- yank visual selection into register
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")

	local chan = open_code_session.buf.channel
	if not chan then
		vim.notify("opencode: no active terminal session", vim.log.levels.WARN)
		return
	end
end, { desc = "Send visual selection to opencode" })
