local logger = require("utils.logger"):new({ name = "plugins.which-key" })

logger:debug("Loading plugins.which-key...")

vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
})

vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, {
	desc = "Buffer Local Keymaps (which-key)",
})
