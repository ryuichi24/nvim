local logger = require("utils.logger"):new({ name = "keymap.window" })

logger:debug("Loading keymap.window...")

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

vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })
