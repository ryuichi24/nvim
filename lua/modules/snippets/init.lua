local logger = require("utils.logger"):new({ name = "modules.snippets" })

logger:debug("Loading modules.snippets...")

require("modules.snippets.config")
