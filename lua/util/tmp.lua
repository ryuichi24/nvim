vim.api.nvim_create_user_command("LspClients", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	local output = vim.inspect(clients)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))
	vim.api.nvim_set_current_buf(buf)
	vim.bo[buf].filetype = "lua" -- syntax highlighting
end, {})
