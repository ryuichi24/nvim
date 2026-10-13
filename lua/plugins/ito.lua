local logger = require("utils.logger"):new({ name = "plugins.ito" })

logger:debug("Loading plugins.ito...")

vim.pack.add({
	{ src = "https://github.com/ryuichi24/ito.nvim" },
})
