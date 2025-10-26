-- space as leader key
vim.g.mapleader = " "

vim.keymap.set("v", "p", '"_dP', { desc = "Paste over currently selected text without yanking it" })

-- Move lines up and down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move down visually selected lines" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move up visually selected lines" })

-- ESC hotkeys
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
vim.keymap.set("v", "q", "<ESC>", { desc = "Exit visual mode with q" })

-- Buffer control
vim.keymap.set("n", "<leader>bu", ":update<CR> :source<CR>", { desc = "Update buffer." })
vim.keymap.set("n", "<leader>s", ":write<CR>", { desc = "Save buffer." })
vim.keymap.set("n", "<leader>bq", ":q<CR>", { desc = "Quit." })
vim.keymap.set("n", "<leader>bk", ":qa<CR>", { desc = "Quit all." })

-- window management
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })
vim.keymap.set("n", "<leader>wb", ":vertical resize +5<CR>", { desc = "Reisze vertically by +5" })
vim.keymap.set("n", "<leader>wc", ":vertical resize -5<CR>", { desc = "Reisze vertically by -5" })
vim.keymap.set("n", "<leader>wj", ":horizontal resize +5<CR>", { desc = "Reisze horizontally by +5" })
vim.keymap.set("n", "<leader>wg", ":horizontal resize -5<CR>", { desc = "Reisze horizontally by -5" })

-- Folding
vim.keymap.set("n", "S", "za", { desc = "Fold lines on cursor." })

-- Serach
vim.keymap.set("n", "/", function()
	local word = vim.fn.expand("<cword>")
	vim.fn.feedkeys("/" .. word, "n")
end, { noremap = true, silent = true, desc = "Search word under cursor" })

vim.keymap.set("v", "/", function()
	local text = get_visual_selection()
	text = vim.fn.escape(text, [[/\]]) -- escape / and \
	vim.fn.feedkeys("/" .. text, "n")
end, { noremap = true, silent = true, desc = "Search visually selected text" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })
