local logger = require("utils.logger"):new({ name = "plugins.aero" })

logger:debug("Loading plugins.aero...")

vim.pack.add({ "https://github.com/ryuichi24/aero.nvim" })

local aero = require("aero")

aero.setup({
	agents = {
		claude = { cmd = { "claude" }, resume = { "claude", "--continue" }, key = "c" },
		codex = { cmd = { "codex" }, resume = { "codex", "resume", "--last" }, key = "x" },
		opencode = { cmd = { "opencode" }, resume = { "opencode", "--continue" }, key = "o" },
		["claude-acp"] = { type = "acp", cmd = { "npx", "-y", "@agentclientprotocol/claude-agent-acp" }, key = "C" },
		["codex-acp"] = { type = "acp", cmd = { "npx", "-y", "@agentclientprotocol/codex-acp" }, key = "X" },
		["opencode-acp"] = { type = "acp", cmd = { "opencode", "acp" }, key = "O" },
	},
	worktree_path = function(ws, branch)
		return vim.fs.joinpath(
			vim.fs.dirname(ws.root),
			vim.fs.basename(ws.root) .. ".worktrees",
			(branch:gsub("/", "-"))
		)
	end,
	dashboard = { position = "left", width = 40 }, -- left | right | current
	panel = { position = "right", width = 80 }, -- left | right; false uses last window
	worktree_tabs = true,
	terminal = { height = 12, cmd = nil }, -- nil uses { vim.o.shell }
	idle_ms = 1500, -- terminal output inactivity before idle
	notify_idle = true, -- notify when hidden sessions become idle
	start_insert = true,
	animation = true,
	fullscreen_key = "gF", -- false disables
	quote_key = "<leader>aq", -- false disables
	resize = { -- false disables
		prefix = "<C-w>",
		keys = { grow = "k", shrink = "j", narrow = "h", widen = "l" },
	},
	persist_sessions = true,
	prompt_session_name = true, -- ask for a name with `a` or agent shortcuts; false uses automatic names
	input = { adapter = "auto", select_default = true }, -- auto | dressing | snacks | vim_ui | function
	persist_buffers = true,
	state_file = vim.fn.stdpath("data") .. "/Aero/state.json",
	events = {}, -- event name -> function or list of functions; "*" observes all events
	layout = { min_code_width = 20 }, -- false disables automatic side-column rebalancing
	acp = {
		max_tool_lines = 20, -- truncate tool output in transcripts
		prompt_height = 25,
		decorations = true, -- native transcript cards, colors, and visual borders
		show_usage = true, -- agent-reported tokens, context usage, and cumulative fees
	},
	reports = {
		directory = "data", -- data | worktree | custom root | function(worktree, workspace_root)
		prompt = "Report file: {path}\nRead this Markdown report for context and write or update the report at this path with your findings.",
	},
	tasks = {
		directory = "data", -- data | worktree | custom root | function(workspace_root)
		yq = vim.env.AERO_TASKS_YQ or "yq",
		states = { "backlog", "todo", "in progress", "review", "test", "done" },
		terminal_states = { "done" },
		estimate_unit = "points",
		column_width = 32,
		agent = {
			enabled = true, -- opt in to task tools for ACP sessions
			executable = false, -- installed binary; or an absolute custom executable path
			adapters = { "opencode-acp", "claude-agent-acp", "codex-acp" }, -- allowed names from the agents table
			prompt = "Read the ticket through Aero's task tools and implement its requirements. Record progress and verification results with aero_update_ticket_body. Discover current board states before explicitly moving the ticket with aero_move_ticket. Do not write the task documents directly.",
		},
		keymaps = {
			open = "<CR>",
			source = "e",
			new = "ga",
			move = "m",
			work = "gw",
			rename = "N",
			remove = "gd",
			delete = "gD",
			metadata = "gi",
			states = "gs",
			refresh = "R",
			previous = "[s",
			next = "]s",
			up = false,
			down = false,
			earlier = "gK",
			later = "gJ",
			recover = "go",
			archive = "gA",
			close = "q",
			help = "g?",
		},
	},
	keymaps = { -- dashboard mappings; false disables an entry
		open = "<CR>",
		expand = "l",
		collapse = "h",
		toggle = "<Tab>",
		open_vsplit = "<C-v>",
		open_split = "<C-x>",
		open_tab = "<C-t>",
		add = "a",
		add_workspace = "A",
		delete = "d",
		stop = "s",
		restart = "r",
		rename = "N",
		refresh = "R",
		pull = "P",
		cd = ".",
		edit = "e",
		open_board_markdown = "I",
		edit_enter = "<C-CR>",
		edit_mouse = "<C-LeftMouse>",
		terminal = "t",
		next_workspace = "]]",
		prev_workspace = "[[",
		close = "q",
		help = "g?",
	},
	icons = {
		expanded = "▾",
		collapsed = "▸",
		busy = "◐",
		idle = "●",
		waiting = "?",
		exited = "✗",
		stopped = "○",
	},
})

vim.keymap.set({ "n" }, "<leader>ar", function()
	aero.open()
end, { desc = "Add Agent" })

vim.keymap.set({ "n" }, "<leader>at", function()
	aero.terminal()
end, { desc = "Add Agent" })

vim.keymap.set("n", "<leader>as", function()
	aero.sessions()
end, { desc = "Search active AI sessions" })

vim.keymap.set("n", "<leader>aw", function()
	aero.worktrees()
end, { desc = "Search worktrees" })

vim.keymap.set("n", "<leader>aW", function()
	aero.workspaces()
end, { desc = "Search workspaces" })
