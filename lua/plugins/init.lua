local logger = require("utils.logger"):new({ name = "plugins" })

logger:debug("Loading plugins...")

require("plugins.oil")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.supermaven")
require("plugins.conform")
require("plugins.java")
require("plugins.noice")
require("plugins.dressing")
require("plugins.nvim-tree")
require("plugins.vim-tmux-navigator")
