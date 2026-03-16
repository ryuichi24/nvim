vim.pack.add({
	-- { src = "https://github.com/ryuichi24/nuko.nvim" },
})

local nuko = require("nuko")

nuko.setup()

vim.keymap.set("n", "<leader>nt", ":Nuko new<CR>")
vim.keymap.set("n", "<leader>nn", ":Nuko toggle<CR>")

vim.keymap.set("n", "<leader>nfn", ":Nuko focus next<CR>")
vim.keymap.set("n", "<leader>nfp", ":Nuko focus prev<CR>")

--
vim.keymap.set("n", "<leader>nf1", ":Nuko focus 1<CR>")
vim.keymap.set("n", "<leader>nf2", ":Nuko focus 2<CR>")
vim.keymap.set("n", "<leader>nf3", ":Nuko focus 3<CR>")
vim.keymap.set("n", "<leader>nf4", ":Nuko focus 4<CR>")

vim.keymap.set("n", "<leader>nc1", ":Nuko close 1<CR>")
vim.keymap.set("n", "<leader>nc2", ":Nuko close 2<CR>")
vim.keymap.set("n", "<leader>nc3", ":Nuko close 3<CR>")
vim.keymap.set("n", "<leader>nc4", ":Nuko close 4<CR>")

vim.keymap.set("n", "<leader>nk", ":Nuko stop<CR>")

vim.api.nvim_create_autocmd("User", {
	pattern = "NukoTermFocus",
	callback = function()
		print("NukoTermFocus")

		-- override mappings
		local opts = { buffer = true, remap = false, silent = true }
		-- vim.keymap.set("n", "<C-y>", ":Nuko move 1 top_left<CR>", opts)
		-- vim.keymap.set("n", "<C-o>", ":Nuko move 1 top_right<CR>", opts)
		-- vim.keymap.set("n", "<C-u>", ":Nuko move 1 bottom_left<CR>", opts)
		-- vim.keymap.set("n", "<C-i>", ":Nuko move 1 bottom_right<CR>", opts)
		-- vim.keymap.set("n", "<C-p>", ":Nuko move 1 center<CR>", opts)
		--
		vim.keymap.set("n", "<ESC>", ":Nuko toggle<CR>", opts)

		local function nuko_move(cmd)
			vim.schedule(function()
				vim.cmd("Nuko move 1 " .. cmd)
			end)
		end

		vim.keymap.set("t", "<C-y>", function()
			nuko_move("top_left")
		end, opts)
		vim.keymap.set("t", "<C-o>", function()
			nuko_move("top_right")
		end, opts)
		vim.keymap.set("t", "<C-u>", function()
			nuko_move("bottom_left")
		end, opts)
		vim.keymap.set("t", "<C-i>", function()
			nuko_move("bottom_right")
		end, opts)
		vim.keymap.set("t", "<C-p>", function()
			nuko_move("center")
		end, opts)
		vim.keymap.set("t", "<ESC>", function()
			vim.schedule(function()
				vim.cmd("Nuko toggle")
			end)
		end, opts)
	end,
})
