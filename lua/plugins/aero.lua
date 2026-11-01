local logger = require("utils.logger"):new({ name = "plugins.aero" })

logger:debug("Loading plugins.aero...")

vim.pack.add({ "https://github.com/ryuichi24/aero.nvim" })

local aero = require("aero")

local tailscale_ip = vim.env.AERO_TAILSCALE_IP
local aero_mcp_exe = vim.env.AERO_MCP_EXE

aero.setup({
	sessions = {
		idle_ms = 1500,
		notify_idle = true,
		start_insert = true,
		prompt_name = true,
	},
	storage = {
		sessions = true,
		buffers = true,
		state_file = vim.fn.stdpath("data") .. "/Aero/state.json",
	},
	worktrees = {
		tabs = true,
		path = function(ws, branch)
			return vim.fs.joinpath(
				vim.fs.dirname(ws.root),
				vim.fs.basename(ws.root) .. ".worktrees",
				(branch:gsub("/", "-"))
			)
		end,
	},
	ui = {
		dashboard = {
			position = "left",
			width = 40,
			sidebar = { line_numbers = { show = true, relative = true } },
			keymaps = {
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
		},
		panel = {
			position = "right",
			width = 80,
			info_open_by_default = false,
			info_height_rows = 6,
			info_auto_position = true,
			info_position_threshold_columns = 120,
		},
		terminal = {
			height = 24,
			cmd = nil, -- nil uses { vim.o.shell }
		},
		layout = {
			min_code_width = 20,
		},
		animation = true,
		fullscreen_key = "gF",
		quote_key = "<leader>aq",
		resize = {
			-- prefix = "<C-w>",
			-- keys = { grow = "k", shrink = "j", narrow = "h", widen = "l" },
			steps = { grow = 8, shrink = 8, narrow = 8, widen = 8 },
		},
		input = {
			adapter = "auto",
			select_default = true,
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
	},
	chat = {
		transcript = {
			max_tool_lines = 20,
			decorations = true,
			show_usage = true,
			image_previews = true,
			line_numbers = {
				show = true,
				relative = true,
			},
		},
		prompt = {
			height = 25,
			tab_completion = false,
			line_numbers = {
				show = true,
				relative = true,
			},
		},
	},
	agents = {
		claude = {
			cmd = { "claude" },
			resume = { "claude", "--continue" },
			key = "c",
		},
		codex = {
			cmd = { "codex" },
			resume = { "codex", "resume", "--last" },
			key = "x",
		},
		opencode = {
			cmd = { "opencode" },
			resume = { "opencode", "--continue" },
			key = "o",
		},
		["claude-agent-acp"] = {
			type = "acp",
			cmd = { "npx", "-y", "@agentclientprotocol/claude-agent-acp" },
			key = "C",
		},
		["codex-acp"] = {
			type = "acp",
			cmd = { "npx", "-y", "@agentclientprotocol/codex-acp" },
			key = "X",
		},
		["opencode-acp"] = {
			type = "acp",
			cmd = { "opencode", "acp" },
			key = "O",
		},
	},
	mcp = {
		executable = aero_mcp_exe or false,
	},
	reading = {
		agent = {
			enabled = true,
		},
		explanation = {
			unfold = true,
		},
	},
	reports = {
		directory = "data",
		prompt = "Report file: {path}\nRead this Markdown report for context and write or update the report at this path with your findings.",
	},
	tasks = {
		directory = "data",
		yq = vim.env.AERO_TASKS_YQ or "yq",
		states = { "backlog", "todo", "in progress", "review", "test", "done" },
		terminal_states = { "done" },
		estimate_unit = "points",
		column_width = 32,
		agent = {
			enabled = true,
			adapters = { "opencode-acp", "claude-agent-acp", "codex-acp" },
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
	companion = {
		bind = tailscale_ip or "127.0.0.1",
		port = 8765,
		origin = "http://" .. (tailscale_ip or "localhost") .. ":8765",
		allow_http = tailscale_ip ~= nil,
		auto_start = true,
		ui = {
			source_collapsed_by_default = true,
		},
	},
	-- pnpm add -g @mermaid-js/mermaid-cli
	mermaid = {
		enabled = true,
	},
	events = {},
})

--

vim.keymap.set({ "n" }, "<leader>ar", function()
	aero.toggle()
end, { desc = "Open dashboard" })

vim.keymap.set("n", "<leader>co", function()
	require("aero").review()
end, { desc = "Aero: review changes" })

vim.keymap.set({ "n" }, "<leader>at", function()
	aero.terminal()
end, { desc = "Toggle worktree terminal" })

vim.keymap.set({ "n" }, "<leader>ai", function()
	require("aero.acp").toggle_prompt()
end, { desc = "Aero: toggle input panel" })

vim.keymap.set({ "n" }, "<leader>af", function()
	require("aero").file()
end, {
	desc = "Aero: add current file to agent prompt",
})

vim.keymap.set({ "v" }, "<leader>aq", function()
	require("aero").quote()
end, {
	desc = "Aero: quote selection into agent prompt",
})

vim.keymap.set("n", "<leader>al", function()
	require("aero").reading()
end, { desc = "Aero: Pick reading list" })

vim.keymap.set("n", "<leader>fw", function()
	aero.worktrees()
end, { desc = "Search worktrees" })

vim.keymap.set("n", "<leader>fW", function()
	aero.workspaces()
end, { desc = "Search workspaces" })

vim.keymap.set("n", "<leader>fa", function()
	aero.sessions()
end, { desc = "Search active AI sessions" })

vim.keymap.set("n", "<leader>rs", function()
	aero.reader("source")
end, { desc = "Reader: Source" })

vim.keymap.set("n", "<leader>re", function()
	aero.reader("exports")
end, { desc = "Reader: Exported logs" })

vim.keymap.set("n", "<leader>rf", function()
	aero.reader("references")
end, { desc = "Reader: References" })

vim.keymap.set("n", "<leader>rr", function()
	aero.reader("reports")
end, { desc = "Reader: Reports" })

vim.keymap.set("n", "<leader>rl", function()
	aero.reader("reading")
end, { desc = "Reader: Reading List" })

-- Change the display mode.
vim.keymap.set("n", "<leader>rm", function()
	aero.reader()
end, { desc = "Reader: Toggle tabs/panes" })

vim.keymap.set("n", "<leader>rt", function()
	aero.reader("tabs")
end, { desc = "Reader: Tabs mode" })

vim.keymap.set("n", "<leader>rp", function()
	aero.reader("panes")
end, { desc = "Reader: Panes mode" })

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = vim.api.nvim_create_augroup("AeroReviewKeymaps", { clear = true }),
	callback = function(event)
		if not vim.b[event.buf].aero_review then
			return
		end

		local function map(key, action, desc)
			vim.keymap.set("n", key, function()
				require("aero.review").command(action)
			end, {
				buffer = event.buf,
				desc = desc,
			})
		end

		map("<leader>rd", "diff", "Review: toggle diff/code")
		map("<leader>rr", "refresh", "Review: refresh")
		map("<leader>rb", "base", "Review: choose base")
		map("<leader>rl", "local", "Review: local changes")
	end,
})

vim.keymap.set("n", "<leader>an", function()
	require("aero").new()
end, { desc = "New agent session" })

vim.keymap.set("n", "<leader>as", function()
	require("aero").pick("current")
end, { desc = "Select worktree session" })

vim.keymap.set("n", "<leader>ag", function()
	require("aero.general").new(require("aero.config").options.default_agent)
end, { desc = "Aero: new general chat with default agent" })
