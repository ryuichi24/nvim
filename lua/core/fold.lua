vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 4

vim.o.foldcolumn = "1"

vim.o.foldmethod = "expr"
vim.o.foldtext = ""

vim.opt.fillchars = {
	fold = " ",
	eob = " ",
	foldclose = "",
	foldopen = "",
	foldsep = " ",
	-- foldinner = " ", -
}

vim.keymap.set("n", "S", "za", { desc = "Toggle fold under cursor." })
vim.keymap.set("n", "FF", "zM", { desc = "Fold all lines." })
vim.keymap.set("n", "FD", "zR", { desc = "Unfold all folded lines." })
