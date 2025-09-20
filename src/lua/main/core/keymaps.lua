vim.g.mapleader = " " -- space as leader key

-- ESC hotkeys
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })
vim.keymap.set("v", "q", "<ESC>", { desc = "Exit insert mode with Q" })

-- Buffer control
vim.keymap.set('n', '<leader>bu', ':update<CR> :source<CR>', { desc = "Update buffer." })
vim.keymap.set('n', '<leader>s', ':write<CR>', { desc = "Save buffer." })
vim.keymap.set('n', '<leader>bq', ':q<CR>', { desc = "Quit." })
vim.keymap.set('n', '<leader>bk', ':qa<CR>', { desc = "Quit all." })

-- window management
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })             -- split window vertically
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })           -- split window horizontally
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })              -- make split windows equal width & height
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })         -- close current split windowim.keymap.set('n', '<leader>d', ':bdelete<CR> :bnext<CR>')
vim.keymap.set("n", "<C-=>", ":vertical resize +5<CR>", { desc = "Reisze vertically by +5" }) -- close current split windowim.keymap.set('n', '<leader>d', ':bdelete<CR> :bnext<CR>')
vim.keymap.set("n", "<C-->", ":vertical resize -5<CR>", { desc = "Reisze vertically by -5" }) -- close current split windowim.keymap.set('n', '<leader>d', ':bdelete<CR> :bnext<CR>')
vim.keymap.set("n", "<C-0>", ":horizontal resize +5<CR>", { desc = "Reisze horizontally by +5" })
vim.keymap.set("n", "<C-9>", ":horizontal resize -5<CR>", { desc = "Reisze horizontally by -5" })

-- Normal mode split navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true })

-- Terminal mode split navigation (optional, if you use :terminal)
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { silent = true })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { silent = true })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { silent = true })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { silent = true })

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
