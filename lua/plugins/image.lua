local logger = require("utils.logger"):new({ name = "plugins.image" })

logger:debug("Loading plugins.image...")

-- install dep with: brew install imagemagick
vim.pack.add({
	"https://github.com/3rd/image.nvim",
})

require("image").setup({
	backend = "kitty",
	processor = "magick_cli",
	integrations = {
		markdown = {
			enabled = true,
			floating_windows = true,
			download_remote_images = false,
			only_render_image_at_cursor = false,
		},
	},
	max_height_window_percentage = 50,
})
