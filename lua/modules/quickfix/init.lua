local logger = require("utils.logger"):new({ name = "modules.quickfix" })

logger:debug("Loading modules.quickfix...")

require("modules.quickfix.config")
