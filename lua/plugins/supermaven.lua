local logger = require("utils.logger"):new({ name = "plugins.supermaven" })

logger:debug("Loading plugins.supermaven...")

vim.pack.add({
	{ src = "https://github.com/supermaven-inc/supermaven-nvim" },
})

local supermaven = require("supermaven-nvim")

supermaven.setup({})
