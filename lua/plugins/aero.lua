local logger = require("utils.logger"):new({ name = "plugins.aero" })

logger:debug("Loading plugins.aero...")

vim.pack.add({ "https://github.com/ryuichi24/aero.nvim" })

local aero = require("aero")

aero.setup({

	agents = {
		-- terminal agents
		claude = { cmd = { "claude" }, resume = { "claude", "--continue" }, key = "c" },
		codex = { cmd = { "codex" }, resume = { "codex", "resume", "--last" }, key = "x" },
		opencode = { cmd = { "opencode" }, resume = { "opencode", "--continue" }, key = "o" },
		-- ACP agents
		["claude-acp"] = { type = "acp", cmd = { "npx", "-y", "@agentclientprotocol/claude-agent-acp" }, key = "C" },
		["codex-acp"] = { type = "acp", cmd = { "npx", "-y", "@agentclientprotocol/codex-acp" }, key = "X" },
		["opencode-acp"] = { type = "acp", cmd = { "opencode", "acp" }, key = "O" },
		-- add your own; set an entry to false to remove a default
		-- gemini = { type = "acp", cmd = { "gemini", "--experimental-acp" }, key = "g" },
	},
	worktree_path = function(ws, branch) -- default: <repo>/../<repo>.worktrees/<branch>
		return vim.fs.joinpath(
			vim.fs.dirname(ws.root),
			vim.fs.basename(ws.root) .. ".worktrees",
			(branch:gsub("/", "-"))
		)
	end,
	dashboard = { position = "left", width = 40 }, -- "left" | "right" | "current" (oil-style)
	panel = { position = "right", width = 70 }, -- where sessions open; false = last used window
	worktree_tabs = true, -- one tab per worktree, :tcd'd to it
	terminal = { height = 12, cmd = nil }, -- worktree shell; cmd defaults to { vim.o.shell }
	idle_ms = 1500, -- terminal agents: no output for this long = idle
	notify_idle = true, -- notify when a hidden session finishes
	start_insert = true, -- enter insert / the prompt buffer when opening a session
	animation = true, -- spinner + live activity ("thinking", the running tool, elapsed time)
	fullscreen_key = "gF", -- normal-mode key in every pane, including code; false disables it
	quote_key = "<leader>aq", -- visual-mode quote from code or agent logs; false disables it
	resize = { prefix = "<C-w>", keys = { grow = "k", shrink = "j", narrow = "h", widen = "l" } }, -- false disables it
	persist_sessions = true,
	persist_buffers = true, -- remember each worktree's last code file/directory and cursor
	state_file = vim.fn.stdpath("data") .. "/Aero/state.json",
	events = {}, -- lifecycle event -> function or list of functions; see above
	acp = { max_tool_lines = 20, prompt_height = 30, decorations = true, show_usage = true },
	keymaps = { --[[ see lua/aero/config.lua; set any to false ]]
	},
})

vim.keymap.set({ "n" }, "<leader>ar", function()
	aero.open()
end, { desc = "Add Agent" })

vim.keymap.set({ "n" }, "<leader>at", function()
	aero.terminal()
end, { desc = "Add Agent" })
