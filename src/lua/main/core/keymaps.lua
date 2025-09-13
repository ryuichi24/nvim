vim.g.mapleader = " " -- space as leader key

-- Move text up and down
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "p", '"_dP', { noremap = true, silent = true })


vim.keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>', { desc = "Update buffer." })
vim.keymap.set('n', '<leader>s', ':write<CR>', { desc = "Save buffer." })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = "Quit." })
vim.keymap.set('n', '<leader>k', ':qa<CR>', { desc = "Quit all." })


-- vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })
--
-- buffer control
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = "Open nect buffer." })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = "Open previous buffer." })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR> :bnext<CR>', { desc = "Delete current buffer." })

-- window management
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })         -- split window vertically
vim.keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })       -- split window horizontally
vim.keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })          -- make split windows equal width & height
vim.keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" })     -- close current split windowim.keymap.set('n', '<leader>d', ':bdelete<CR> :bnext<CR>')

vim.keymap.set("n", "+", ":vertical resize +5<CR>", { desc = "Reisze vertically by +5" }) -- close current split windowim.keymap.set('n', '<leader>d', ':bdelete<CR> :bnext<CR>')
vim.keymap.set("n", "-", ":vertical resize -5<CR>", { desc = "Reisze vertically by -5" }) -- close current split windowim.keymap.set('n', '<leader>d', ':bdelete<CR> :bnext<CR>')
vim.keymap.set("n", "9", ":horizontal resize +5<CR>", { desc = "Reisze horizontally by +5" })
vim.keymap.set("n", "0", ":horizontal resize -5<CR>", { desc = "Reisze horizontally by -5" })

-- Snippet navigation
vim.keymap.set({ "i", "s" }, "<Tab>", function()
    if require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
    if require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
    end
end, { silent = true })

-- folding
vim.keymap.set("n", "S", "za", { desc = "Fold lines on cursor." }) -- close current split windowim.keymap.set('n', '<leader>d', ':bdelete<CR> :bnext<CR>')

-- Use Ctrl + A for select all, but keep original increment on numbers
vim.keymap.set('n', '<C-a>', function()
    local col = vim.fn.col('.')
    local line = vim.fn.getline('.')
    if line:sub(col, col):match('%d') then
        -- If cursor is on a digit, do normal increment
        return '<C-a>'
    else
        -- Otherwise select all
        return 'ggVG'
    end
end, { expr = true, desc = 'Smart Ctrl+A (increment or select all)' })



-- Function to get the visual selection
local function get_visual_selection()
    vim.cmd('noau normal! "vy"') -- yank selection into register v
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})       -- clear register
    return text
end

-- Normal mode: search word under cursor
vim.keymap.set("n", "/", function()
    local word = vim.fn.expand("<cword>")
    vim.fn.feedkeys("/" .. word, "n")
end, { noremap = true, silent = true })

-- Visual mode: search selected text
vim.keymap.set("v", "/", function()
    local text = get_visual_selection()
    text = vim.fn.escape(text, [[/\]]) -- escape / and \
    vim.fn.feedkeys("/" .. text, "n")
end, { noremap = true, silent = true })
