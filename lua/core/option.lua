-- use system clipboard
vim.opt.clipboard:append("unnamedplus")

-- Editor Visual
vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line number
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = true -- no wrapping lines
vim.opt.list = true -- show whitespace
vim.opt.listchars = {
	-- {tab_char}{fill_char}
	tab = "▸▸",
	trail = "·",
	extends = "›",
	precedes = "‹",
	nbsp = "␣",
} -- symbols for spaces

-- Editor Behavior
vim.opt.autowrite = false -- auto save
-- vim.opt.iskeyword:append("_")
vim.opt.iskeyword:remove("_")
-- vim.opt.iskeyword:append("-")
-- vim.opt.iskeyword:remove("-")

-- Window Visual
-- | Value    | Appearance                      |
-- | -------- | ------------------------------- |
-- | `rounded`| Rounded corners                 |
-- | `single` | Clean single-line box           |
-- | `double` | Thick double-line box           |
-- | `solid`  | Solid block border              |
-- | `shadow` | Subtle shadow effect            |
-- | `none`   | No border                       |
vim.opt.winborder = "rounded" -- Set floating window border style

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Device
-- | Value | Modes affected    |
-- | ----- | ----------------- |
-- | `n`   | Normal mode       |
-- | `v`   | Visual mode       |
-- | `i`   | Insert mode       |
-- | `c`   | Command-line mode |
-- | `h`   | Help buffers      |
-- | `a`   | All of the above  |
vim.opt.mouse = "a" -- Enable mouse support

-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.nvim/undodir")
