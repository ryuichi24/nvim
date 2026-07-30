local logger = require("utils.logger"):new({ name = "modules.tab.config" })

logger:debug("Loading modules.tab.config...")

vim.o.showtabline = 2

vim.o.tabline = "%!v:lua.MyTabline()"

function _G.MyTabline()
	local s = ""

	for i = 1, vim.fn.tabpagenr("$") do
		local winnr = vim.fn.tabpagewinnr(i)
		local buflist = vim.fn.tabpagebuflist(i)
		local bufnr = buflist[winnr]
		local name = vim.fn.bufname(bufnr)

		if name == "" then
			name = "[No Name]"
		else
			name = vim.fn.fnamemodify(name, ":t")
		end

		-- highlight current tab
		if i == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end

		local modified = vim.fn.getbufvar(bufnr, "&modified")
		if modified == 1 then
			name = name .. " " .. "●"
		else
			name = name .. " " .. " "
		end

		s = s .. "%" .. i .. "T " .. i .. ": " .. name .. " "
	end

	s = s .. "%#TabLineFill#%T"
	return s
end

-- color them
vim.api.nvim_set_hl(0, "TabLineSel", {
	fg = "#3e3e42",
	bg = "#aaaaaa",
	bold = true,
})

vim.api.nvim_set_hl(0, "TabLine", {
	fg = "#3e3e42",
	bg = "#1e1e1e",
})

vim.api.nvim_set_hl(0, "TabLineFill", {
	--
})

---@type vim.keymap.set.Opts
local opts = { silent = true }

opts.desc = "New tab"
vim.keymap.set("n", "<leader>tm", ":tabnew<CR>", opts)

opts.desc = "Close tab"
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", opts)

opts.desc = "Close all but current tab"
vim.keymap.set("n", "<leader>tq", ":tabonly<CR>", opts)

opts.desc = "Go next tab"
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", opts)

opts.desc = "Go previous tab"
vim.keymap.set("n", "<leader>tp", ":tabprevious 1<CR>", opts)

opts.desc = "Go to tab 1"
vim.keymap.set("n", "<leader>t1", ":tabnext 1<CR>", opts)

opts.desc = "Go to tab 2"
vim.keymap.set("n", "<leader>t2", ":tabnext 2<CR>", opts)

opts.desc = "Go to tab 3"
vim.keymap.set("n", "<leader>t3", ":tabnext 3<CR>", opts)

opts.desc = "Go to tab 4"
vim.keymap.set("n", "<leader>t4", ":tabnext 4<CR>", opts)

opts.desc = "Go to tab 5"
vim.keymap.set("n", "<leader>t5", ":tabnext 5<CR>", opts)

opts.desc = "Go to tab 6"
vim.keymap.set("n", "<leader>t6", ":tabnext 6<CR>", opts)

opts.desc = "Go to tab 7"
vim.keymap.set("n", "<leader>t7", ":tabnext 7<CR>", opts)

opts.desc = "Go to tab 8"
vim.keymap.set("n", "<leader>t8", ":tabnext 8<CR>", opts)

opts.desc = "Go to tab 9"
vim.keymap.set("n", "<leader>t9", ":tabnext 9<CR>", opts)
