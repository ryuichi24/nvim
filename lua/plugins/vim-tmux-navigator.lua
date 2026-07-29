local logger = require("utils.logger"):new({ name = "plugins.vim-tmux-navigator" })

logger:debug("Loading plugins.vim-tmux-navigator...")

vim.pack.add({
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
})
