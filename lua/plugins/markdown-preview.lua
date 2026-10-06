--
local logger = require("utils.logger"):new({ name = "plugins.markdown-preview" })

logger:debug("Loading plugins.markdown-preview...")

vim.pack.add({
	{
		name = "markdown-preview",
		src = "https://github.com/iamcco/markdown-preview.nvim",
		version = "master",
	},
})

-- build after install/update
vim.api.nvim_create_autocmd("PackChanged", {
	pattern = "markdown-preview.nvim",
	callback = function(ev)
		if ev.data.kind ~= "delete" then
			vim.fn["mkdp#util#install"]() -- downloads prebuilt binary
			-- or, if you have node+yarn:
			-- vim.system({'sh','-c','cd ' .. ev.data.path .. '/app && npx --yes yarn install'})
		end
	end,
})

vim.keymap.set("n", "<leader>mm", "<Plug>MarkdownPreviewToggle", { desc = "Markdown preview" })

-- installed binary is broken
-- :call mkdp#util#install()
-- so do this:
-- rm ~/.local/share/nvim/site/pack/core/opt/markdown-preview/app/bin/markdown-preview-macos-arm64
-- cd ~/.local/share/nvim/site/pack/core/opt/markdown-preview/app
-- npx --yes yarn install
