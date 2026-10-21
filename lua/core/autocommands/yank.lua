local logger = require("utils.logger"):new({ name = "autocommands.yank" })

logger:debug("Loading autocommands.yank...")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()

		local event = vim.v.event
		-- Forward yanks to attached terminals too: pbcopy only updates this host.
		-- A tmux server can have SSH clients even without SSH_CONNECTION here.
		if
			event.operator == "y"
			and (event.regname == "" or event.regname == "+" or event.regname == "*")
			and vim.tbl_contains(vim.opt.clipboard:get(), "unnamedplus")
			and (vim.env.TMUX or vim.env.SSH_CONNECTION or vim.env.SSH_TTY)
		then
			require("vim.ui.clipboard.osc52").copy("+")(event.regcontents)
		end
	end,
})
