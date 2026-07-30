local logger = require("utils.logger"):new({ name = "modules.git.lazygit" })

logger:debug("Loading modules.git.lazygit...")

vim.pack.add({
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
})

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { silent = true, noremap = true })
