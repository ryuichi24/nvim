local logger = require("utils.logger"):new({ name = "theme" })

logger:debug("Loading theme...")

-- Available themes: graphite, catppuccin, tokyonight, kanagawa, gruvbox, rosepine.
local theme = "graphite"

require("core.theme." .. theme)
