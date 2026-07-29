local logger = require("utils.logger"):new({ name = "autocommands" })

logger:debug("Loading autocommands...")

require("core.autocommands.yank")
