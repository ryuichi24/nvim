local logger = require("utils.logger"):new({ name = "theme" })

logger:debug("Loading theme...")

require("core.theme.tokyonight")
