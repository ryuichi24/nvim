local logger = require("utils.logger"):new({ name = "modules.git.config" })

logger:debug("Loading modules.git.config...")

vim.pack.add({
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
})

vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<cr>", { silent = true, noremap = true })
