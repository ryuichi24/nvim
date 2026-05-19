vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldmethod = "expr" -- how to determine fold level

-- vim.opt.foldlevel = 99 -- open all folder at first
vim.opt.foldlevelstart = 1 -- open all but first level is folded
vim.opt.foldnestmax = 8

vim.o.foldcolumn = "1"

vim.o.foldtext = "" -- disable default fold text for syntax highlight by treesitter

vim.opt.fillchars = {
	fold = " ", -- fill foldcolumn with space
	foldclose = "",
	foldopen = "",
	foldsep = " ", -- separator between foldcolumn and content
}

vim.keymap.set("n", "S", "za", { desc = "Toggle fold under cursor." })
vim.keymap.set("n", "FF", "zM", { desc = "Fold all lines." })
vim.keymap.set("n", "FD", "zR", { desc = "Unfold all folded lines." })
