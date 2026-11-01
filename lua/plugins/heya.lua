local logger = require("utils.logger"):new({ name = "plugins.heya" })

logger:debug("Loading plugins.heya...")

vim.pack.add({
	{ src = "https://github.com/ryuichi24/heya.nvim" },
})
