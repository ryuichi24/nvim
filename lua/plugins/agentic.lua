local logger = require("utils.logger"):new({ name = "plugins.agentic" })

logger:debug("Loading plugins.agentic...")

vim.pack.add({ "https://github.com/carlos-algms/agentic.nvim" })

require("agentic").setup({
	provider = "codex-acp",
	windows = {
		position = "left",
		width = "40%", -- Sidebar width (position = "right" or "left")
		height = "30%", -- Panel height (position = "bottom")
	},
	diff_preview = {
		enabled = true,
		layout = "split", -- "split" or "inline"
		center_on_navigate_hunks = true,
	},
})

vim.keymap.set({ "n", "v", "i" }, "<leader>at", function()
	require("agentic").toggle()
end, { desc = "Toggle Agentic Chat" })

vim.keymap.set({ "n", "v" }, "<leader>ap", function()
	require("agentic").add_selection_or_file_to_context()
end, { desc = "Add file or selection to Agentic Context" })

vim.keymap.set({ "n", "v", "i" }, "<leader>an", function()
	require("agentic").new_session()
end, { desc = "New Agentic Session" })

vim.keymap.set({ "n", "v", "i" }, "<leader>ar", function()
	require("agentic").restore_session()
end, {
	desc = "Agentic Restore Session",
	silent = true,
})

vim.keymap.set("n", "<leader>ad", function()
	require("agentic").add_current_line_diagnostics()
end, { desc = "Add current line diagnostic to Agentic" })

vim.keymap.set("n", "<leader>aD", function()
	require("agentic").add_buffer_diagnostics()
end, { desc = "Add all buffer diagnostics to Agentic" })

vim.keymap.set({ "n", "v", "i" }, "<leader>aw", function()
	require("agentic").rotate_layout({ "right", "bottom", "left" })
end, { desc = "Rotate Agentic window (right/bottom/left)" })
