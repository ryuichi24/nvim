vim.keymap.set("t", "<C-k>", [[<C-\><C-n>]], { desc = "Exit terminal mode with jj." })

vim.api.nvim_create_augroup("custom-term-cmd", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Disable line numbers and other UI elements for terminal buffers",
	group = "custom-term-cmd",
	pattern = "term://*",
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
		vim.opt.signcolumn = "no"
		vim.opt.cursorline = true
		vim.opt.cursorcolumn = false
		vim.opt.colorcolumn = ""
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Start insert mode and set fixed height for terminal buffers",
	group = "custom-term-cmd",
	pattern = "term://*",
	command = "startinsert | set winfixheight",
})

local term_channel_id = nil

vim.keymap.set("n", "<leader>tt", function()
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 20)
	term_channel_id = vim.bo.channel
end, { desc = "Open a new terminal session in the bottom window." })

vim.keymap.set("n", "<leader>tk", function()
	if term_channel_id then
		local ctrl_c = "\x03" -- ASCII for Ctrl+C
		vim.fn.chansend(term_channel_id, ctrl_c)
		vim.fn.chansend(term_channel_id, "exit\r\n")
	end
end, { desc = "Exit from the current opened term session." })

-- terminal
-- local Terminal = {}
-- Terminal.__index = Terminal
--
-- Terminal.win = nil
-- Terminal.buf = nil
--
-- function Terminal:toggle()
-- 	if self.win and vim.api.nvim_win_is_valid(self.win) then
-- 		vim.api.nvim_win_close(self.win, true)
-- 		self.win = nil
-- 		self.buf = nil
-- 		return
-- 	end
--
-- 	local buf = vim.api.nvim_create_buf(false, true)
-- 	local width = math.floor(vim.o.columns * 0.6)
-- 	local height = math.floor(vim.o.lines * 0.4)
-- 	local row = math.floor((vim.o.lines - height) / 2 - 1)
-- 	local col = math.floor((vim.o.columns - width) / 2)
--
-- 	local opts = {
-- 		relative = "editor",
-- 		width = width,
-- 		height = height,
-- 		row = row,
-- 		col = col,
-- 		style = "minimal",
-- 		border = "rounded",
-- 	}
--
-- 	local win = vim.api.nvim_open_win(buf, true, opts)
--
-- 	vim.fn.termopen(vim.o.shell)
-- 	vim.api.nvim_buf_set_option(buf, "buflisted", false)
-- 	vim.api.nvim_buf_set_option(buf, "buftype", "terminal")
-- 	vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
--
-- 	vim.api.nvim_buf_set_keymap(
-- 		buf,
-- 		"t",
-- 		"<Esc>",
-- 		[[<C-\><C-n>:lua _G.terminal:toggle()<CR>]],
-- 		{ noremap = true, silent = true }
-- 	)
--
-- 	vim.cmd("startinsert")
--
-- 	self.win = win
-- 	self.buf = buf
-- end
--
-- _G.terminal = Terminal
--
-- vim.api.nvim_set_keymap("n", "<leader>tt", [[<cmd>lua _G.terminal:toggle()<CR>]], { noremap = true, silent = true })
