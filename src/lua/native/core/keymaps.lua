-- space as leader key
vim.g.mapleader = " "

vim.keymap.set("v", "p", '"_dP', { desc = "Paste over currently selected text without yanking it" })
vim.keymap.set({ "n", "v" }, "$", 'g_', { desc = "Move to end of line, ignoring trailing whitespace" })

-- Select all
vim.keymap.set("n", "<leader>aa", "ggVG", { desc = "Select all" })

-- Move lines up and down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move down visually selected lines" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move up visually selected lines" })

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

-- ESC hotkeys
vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
vim.keymap.set("v", "e", "<ESC>", { desc = "Exit visual mode with q" })

-- Buffer control
vim.keymap.set("n", "<leader>bu", ":update<CR> :source<CR>", { desc = "Update buffer." })
vim.keymap.set("n", "<leader>s", ":write<CR>", { desc = "Save buffer." })
vim.keymap.set("n", "<leader>bq", ":q<CR>", { desc = "Quit." })
vim.keymap.set("n", "<leader>bk", ":qa<CR>", { desc = "Quit all." })

-- window management
vim.keymap.set("n", "<leader>wh", "<cmd>leftabove vnew<CR>", { desc = "Empty split left" })
vim.keymap.set("n", "<leader>wj", "<cmd>belowright new<CR>", { desc = "Empty split down" })
vim.keymap.set("n", "<leader>wk", "<cmd>aboveleft new<CR>", { desc = "Empty split up" })
vim.keymap.set("n", "<leader>wl", "<cmd>rightbelow vnew<CR>", { desc = "Empty split right" })

vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })

-- Resize windows from the active pane
vim.keymap.set("n", "<C-A-h>", "<C-w><", { desc = "Shrink width" })
vim.keymap.set("n", "<C-A-l>", "<C-w>>", { desc = "Grow width" })
vim.keymap.set("n", "<C-A-k>", "<C-w>+", { desc = "Grow height" })
vim.keymap.set("n", "<C-A-j>", "<C-w>-", { desc = "Shrink height" })

vim.keymap.set('n', '<leader>yc', function()
    local cwd = vim.fn.getcwd()
    vim.fn.setreg('+', cwd)
    print("📋 Copied CWD: " .. cwd)
end, { desc = 'Copy current working directory to clipboard' })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Wrap selected texts
vim.keymap.set("v", "<leader>w(", 'c(<C-r>")<ESC>', { silent = true })
vim.keymap.set("v", "<leader>w[", 'c[<C-r>"]<ESC>', { silent = true, })
vim.keymap.set("v", "<leader>w{", 'c{<C-r>"}<ESC>', { silent = true, })
vim.keymap.set("v", "<leader>w\"", 'c\"<C-r>"\"<ESC>', { silent = true, })
vim.keymap.set("v", "<leader>w'", 'c\'<C-r>"\'<ESC>', { silent = true, })
vim.keymap.set("v", "<leader>w`", 'c`<C-r>"`<ESC>', { silent = true, })
