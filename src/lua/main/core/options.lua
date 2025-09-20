vim.opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Search
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true  -- Case sensitive if uppercase in search
vim.opt.hlsearch = true   -- Highlight search results
vim.opt.incsearch = true  -- Show matches as you type

-- Visual
vim.opt.number = true                                       -- Line numbers
vim.opt.relativenumber = true                               -- Relative line numbers
vim.opt.cursorline = true                                   -- Highlight current line
vim.opt.wrap = false                                        -- Don't wrap lines
vim.opt.scrolloff = 10                                      -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8                                   -- Keep 8 columns left/right of cursor
vim.opt.termguicolors = true                                -- Enable 24-bit colors
vim.opt.showmatch = true                                    -- Highlight matching brackets
vim.opt.list = true                                         -- Highlight matching brackets
vim.opt.winborder = 'rounded'                               -- Change border of floating windows rounded
vim.opt.listchars = { tab = '>>', trail = '.', nbsp = '@' } -- Highlight matching brackets


-- Indentation
vim.opt.tabstop = 4        -- Tab width
vim.opt.shiftwidth = 4     -- Indent width
vim.opt.softtabstop = 4    -- Soft tab stop
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true  -- Copy indent from current line
vim.opt.wrap = true        -- ?
vim.opt.breakindent = true -- ?

vim.opt.mouse = "a"        -- Enable mouse support
vim.opt.autowrite = false  -- Don't auto save

-- Undo
vim.opt.undofile = true                           -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory

vim.opt.encoding = "UTF-8"                        -- Set encoding

vim.opt.iskeyword:append("_")                     -- Treat underscore as part of word
