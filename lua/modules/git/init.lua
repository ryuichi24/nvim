local logger = require("utils.logger"):new({ name = "modules.git" })

logger:debug("Loading modules.git...")

require("modules.git.config")
