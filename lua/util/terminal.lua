---@class Win
---@field id number | nil
---@field height? number | nil
---@field width? number | nil
---@field is_maximized? boolean

---@class Buf
---@field id number | nil

---@class BufferSession
---@field buf Buf | nil
---@field win Win | nil

---@type BufferSession
local term_session = {
	buf = {
		id = nil,
	},
	win = {
		id = nil,
		height = math.floor(vim.o.lines * 0.3),
		is_maximized = false,
	},
}

local function toggle_term()
	if term_session.win.id and vim.api.nvim_win_is_valid(term_session.win.id) then
		vim.api.nvim_win_close(term_session.win.id, true)
		term_session.win.id = nil
		return
	end

	if term_session.buf.id and vim.api.nvim_buf_is_valid(term_session.buf.id) then
		vim.cmd("belowright split")
		term_session.win.id = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_height(term_session.win.id, term_session.win.height)
		vim.api.nvim_win_set_buf(term_session.win.id, term_session.buf.id)
	else
		vim.cmd("belowright split")
		term_session.win.id = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_height(term_session.win.id, term_session.win.height)
		vim.cmd("terminal")
		term_session.buf.id = vim.api.nvim_get_current_buf()
	end

	vim.cmd.startinsert()
end

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function(evt)
		local name = vim.api.nvim_buf_get_name(0)

		if name:match("lazygit") then
			print("lazygit is detected. TermOpen")
			return
		end

		local opts = { buffer = evt.buf, silent = true }

		opts.desc = "Exit terminal mode with jj."
		vim.keymap.set("t", "jj", [[<C-\><C-n>]], opts)

		opts.desc = "Toggle Terminal Session."
		vim.keymap.set({ "n", "t" }, "<C-t>", toggle_term, opts)

		opts.desc = "Maximize terminal window."
		vim.keymap.set({ "n", "t" }, "<C-A-m>", function()
			if not term_session.win.is_maximized then
				vim.cmd("wincmd _")
				vim.cmd("wincmd |")

				term_session.win.is_maximized = true
			else
				vim.api.nvim_win_set_height(term_session.win.id, term_session.win.height)
				term_session.win.is_maximized = false
			end
		end, opts)

		opts.desc = "Close Terminal Session"
		vim.keymap.set({ "n", "t" }, "<C-d>", function()
			if vim.bo.buftype ~= "terminal" then
				return
			end

			if term_session.buf.id and vim.api.nvim_buf_is_valid(term_session.buf.id) then
				vim.api.nvim_buf_delete(term_session.buf.id, { force = true })
			end

			if term_session.win.id and vim.api.nvim_win_is_valid(term_session.win.id) then
				vim.api.nvim_win_close(term_session.win.id, true)
			end

			term_session.buf.id = nil
			term_session.win.id = nil
			term_session.win.is_maximized = false
		end, opts)
	end,
})

vim.keymap.set("n", "<leader>tt", toggle_term, { desc = "Toggle Terminal Session" })
