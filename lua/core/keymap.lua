vim.g.mapleader = " "

-- ESC hotkey
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj." })

-- save a current buffer
vim.keymap.set("n", "<leader>s", ":write<CR>", { desc = "Save buffer." })

-- open a folder explore
vim.keymap.set("n", "<leader>ee", ":Ex<CR>", { desc = "Open a folder explore." })

-- select all texts
vim.keymap.set("n", "<leader>aa", "ggVG", { desc = "Select all texts." })

-- Move lines up and down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move down visually selected lines" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move up visually selected lines" })

vim.keymap.set("v", "p", '"_dP', { desc = "Paste over currently selected text without yanking it" })
vim.keymap.set({ "n", "v" }, "$", "g_", { desc = "Move to end of line, ignoring trailing whitespace" })

-- Search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- vim.notify()
-- vim.inspect()
-- vim.notify(vim.inspect(package.loaded["user.keymap"]))

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

-- reload nvim config
vim.keymap.set("n", "<leader>cr", function()
	_G.ReloadConfig("core")
end, { desc = "nvim config has been reloaded!" })

-- search for a file by name
-- https://gist.github.com/romainl/7e2b425a1706cd85f04a0bd8b3898805#the-short-sighted-way
-- https://www.reddit.com/r/neovim/comments/1n53u4u/you_dont_need_a_fuzzy_finder_vim_tips_tricks
vim.cmd("set path+=**")
vim.cmd("set wildignore+=**/.git/*,**/node_modules/*,**/dist/*,**/build/*")

vim.keymap.set("n", "<leader>ff", function()
	vim.api.nvim_feedkeys(":find ", "n", false)
end, { desc = "Search and open a file" })

-- buffer control
vim.keymap.set(
	"n",
	"<leader>be",
	":e!<CR>",
	{ desc = "throw away your current buffer and load the newer version from disk" }
)
vim.keymap.set("n", "<leader>bk", ":qa!<CR>", { desc = "Quit all." })

-- Wrap selected texts
vim.keymap.set("v", "<leader>w(", 'c(<C-r>")<ESC>', { silent = true })
vim.keymap.set("v", "<leader>w[", 'c[<C-r>"]<ESC>', { silent = true })
vim.keymap.set("v", "<leader>w{", 'c{<C-r>"}<ESC>', { silent = true })
vim.keymap.set("v", '<leader>w"', 'c"<C-r>""cESC>', { silent = true })
vim.keymap.set("v", "<leader>w'", "c'<C-r>\"'<ESC>", { silent = true })
vim.keymap.set("v", "<leader>w`", 'c`<C-r>"`<ESC>', { silent = true })
vim.keymap.set("v", "<leader>wt", function()
	local tag = vim.fn.input("Tag: ")

	local keys = "c<" .. tag .. ">" .. vim.api.nvim_replace_termcodes('<C-r>"', true, false, true) .. "</" .. tag .. ">"

	vim.api.nvim_feedkeys(keys, "n", false)
end, { silent = true })

-- Window Management
vim.keymap.set("n", "<leader>wh", "<cmd>leftabove vnew<CR>", { desc = "Empty split left" })
vim.keymap.set("n", "<leader>wj", "<cmd>belowright new<CR>", { desc = "Empty split down" })
vim.keymap.set("n", "<leader>wk", "<cmd>aboveleft new<CR>", { desc = "Empty split up" })
vim.keymap.set("n", "<leader>wl", "<cmd>rightbelow vnew<CR>", { desc = "Empty split right" })
-- Resize windows from the active pane
vim.keymap.set("n", "<C-A-h>", "<C-w><", { desc = "Shrink width" })
vim.keymap.set("n", "<C-A-l>", "<C-w>>", { desc = "Grow width" })
vim.keymap.set("n", "<C-A-k>", "<C-w>+", { desc = "Grow height" })
vim.keymap.set("n", "<C-A-j>", "<C-w>-", { desc = "Shrink height" })
--
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })

-- utils
vim.keymap.set("n", "<leader>ou", function()
	local text = vim.fn.getreg("+")
	if text == "" then
		vim.notify("Clipboard is empty", vim.log.levels.WARN)
		return
	end

	local url
	if text:match("^https?://") then
		-- Looks like a URL, open directly
		url = text
	else
		-- Not a URL → Google search
		local encoded = text:gsub(" ", "+")
		url = "https://www.google.com/search?q=" .. encoded
	end

	-- Open URL depending on OS
	local cmd
	if vim.fn.has("mac") == 1 then
		cmd = { "open", url }
	elseif vim.fn.has("unix") == 1 then
		cmd = { "xdg-open", url }
	elseif vim.fn.has("win32") == 1 then
		cmd = { "cmd.exe", "/c", "start", url }
	else
		vim.notify("Unsupported OS", vim.log.levels.ERROR)
		return
	end

	vim.fn.jobstart(cmd, { detach = true })
end, { desc = "Open URL or Google search from clipboard" })

-- Function to open a disposable floating buffer
local function open_disposable_buffer()
	-- Create a new scratch buffer
	local buf = vim.api.nvim_create_buf(false, true) -- [listed=false, scratch=true]

	-- Get screen dimensions
	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.4)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Create a floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	-- Optional: allow closing buffer with <Esc>
	vim.keymap.set("n", "<Esc>", function()
		vim.api.nvim_win_close(win, true)
	end, { buffer = buf })

	-- Optional: enter insert mode automatically
	vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>mm", open_disposable_buffer, { noremap = true, silent = true })

-- Open ChatGPT with clipboard content as prompt
vim.keymap.set("n", "<leader>cc", function()
	local text = vim.fn.getreg("+")
	if text == "" then
		vim.notify("Clipboard is empty", vim.log.levels.WARN)
		return
	end

	local encoded = text:gsub(" ", "+")
	local url = "https://chatgpt.com/?temporary-chat=true&prompt=" .. encoded

	-- Open URL depending on OS
	local cmd
	if vim.fn.has("mac") == 1 then
		cmd = { "open", url }
	elseif vim.fn.has("unix") == 1 then
		cmd = { "xdg-open", url }
	elseif vim.fn.has("win32") == 1 then
		cmd = { "cmd.exe", "/c", "start", url }
	else
		vim.notify("Unsupported OS", vim.log.levels.ERROR)
		return
	end

	vim.fn.jobstart(cmd, { detach = true })
end, { desc = "Ask ChatGPT with a prompt" })

-- terminal
local Terminal = {}
Terminal.__index = Terminal

Terminal.win = nil
Terminal.buf = nil

function Terminal:toggle()
	if self.win and vim.api.nvim_win_is_valid(self.win) then
		vim.api.nvim_win_close(self.win, true)
		self.win = nil
		self.buf = nil
		return
	end

	local buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.4)
	local row = math.floor((vim.o.lines - height) / 2 - 1)
	local col = math.floor((vim.o.columns - width) / 2)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, opts)

	vim.fn.termopen(vim.o.shell)
	vim.api.nvim_buf_set_option(buf, "buflisted", false)
	vim.api.nvim_buf_set_option(buf, "buftype", "terminal")
	vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")

	vim.api.nvim_buf_set_keymap(
		buf,
		"t",
		"<Esc>",
		[[<C-\><C-n>:lua _G.terminal:toggle()<CR>]],
		{ noremap = true, silent = true }
	)

	vim.cmd("startinsert")

	self.win = win
	self.buf = buf
end

_G.terminal = Terminal

vim.api.nvim_set_keymap("n", "<leader>tt", [[<cmd>lua _G.terminal:toggle()<CR>]], { noremap = true, silent = true })
