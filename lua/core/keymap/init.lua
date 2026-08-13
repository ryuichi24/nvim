local logger = require("utils.logger"):new({ name = "keymap" })

logger:debug("Loading keymap...")

-- Leader key (must be set before loading keymap)
vim.g.mapleader = " "

require("core.keymap.wrap")
require("core.keymap.window")

-- ESC hotkey
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj." })

-- save a current buffer
vim.keymap.set("n", "<leader>s", ":update<CR>", { desc = "Save buffer." })

-- select all texts
vim.keymap.set("n", "<leader>aa", "ggVG", { desc = "Select all texts." })

-- Move lines up and down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move down visually selected lines" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move up visually selected lines" })

-- Paste without yanking
vim.keymap.set("x", "p", "P", {
	desc = "Paste over selection without replacing register",
})

--  Move to end of line, ignoring trailing whitespace
vim.keymap.set({ "n", "v" }, "$", "g_", { desc = "Move to end of line, ignoring trailing whitespace" })

-- move
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- List history of executed commands
vim.keymap.set("n", ";", "q:", { desc = "List history of executed commands" })

-- buffer control
vim.keymap.set(
	"n",
	"<leader>be",
	":e!<CR>",
	{ desc = "throw away your current buffer and load the newer version from disk" }
)

vim.keymap.set("n", "<leader>bk", ":qa!<CR>", { desc = "Quit all." })

vim.keymap.set("n", "<leader>yy", function()
	local current_buf_path = vim.api.nvim_buf_get_name(0)
	vim.fn.setreg("+", current_buf_path)
	print("Copied: " .. current_buf_path)
	print("Copied current file : " .. current_buf_path)
end, { desc = "Copy current file path" })
