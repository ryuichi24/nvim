local logger = require("utils.logger"):new({ name = "modules.terminal" })

logger:debug("Loading modules.terminal...")

require("modules.terminal.config")
