# Themes

Set `theme` in `lua/core/theme/init.lua`, then restart Neovim:

```lua
local theme = "graphite"
```

| Name | Appearance |
| --- | --- |
| `graphite` | Charcoal background, subtle borders, and muted syntax colors. Built on TokyoNight's syntax and plugin integrations. |
| `catppuccin` | Catppuccin Mocha: dark background with soft pastel syntax colors. |
| `tokyonight` | The existing customized, transparent blue TokyoNight theme. |

The Graphite and Catppuccin themes use opaque backgrounds so their palettes
look consistent regardless of the terminal's background color. Plugins are installed
through `vim.pack` when their theme is first loaded.
