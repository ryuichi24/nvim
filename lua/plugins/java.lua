local logger = require("utils.logger"):new({ name = "plugins.java" })

logger:debug("Loading plugins.java...")

vim.pack.add({
	{
		src = "https://github.com/JavaHello/spring-boot.nvim",
		version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
	},
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/mfussenegger/nvim-dap",

	"https://github.com/nvim-java/nvim-java",
})

local jdtls_bin_path = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "packages", "jdtls")

logger:debug("Setting up JDTLS...", { jdtls_bin_path = jdtls_bin_path })

require("java").setup({
	jdtls = {
		version = "1.60.0",
		path = jdtls_bin_path,
		auto_install = false,
	},
	spring_boot_tools = {
		enable = true,
		version = "1.55.1",
		path = nil,
		auto_install = true,
	},
})
