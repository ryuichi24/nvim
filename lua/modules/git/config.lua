local logger = require("utils.logger"):new({ name = "modules.git.config" })

logger:debug("Loading modules.git.config...")

require("modules.git.gitsigns")
require("modules.git.lazygit")
