local logger = require("utils.logger"):new({ name = "custom-plugins" })

logger:debug("Loading custom-plugins...")

require("custom-plugins.spring-boot-init-nvim")
