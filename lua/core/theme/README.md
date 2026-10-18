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
| `kanagawa` | Kanagawa Wave: muted ink-like blues with warm, balanced syntax colors. |
| `gruvbox` | Gruvbox dark with hard contrast: warm earthy colors on a deep charcoal background. |
| `rosepine` | Rosé Pine Main: soft rose, gold, and lavender colors on a dark purple background. |

All themes except TokyoNight use opaque backgrounds so their palettes
look consistent regardless of the terminal's background color. Plugins are installed
through `vim.pack` when their theme is first loaded.
