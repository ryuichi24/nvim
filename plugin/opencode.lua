vim.pack.add({
    { src = "https://github.com/NickvanDyke/opencode.nvim" }
})

vim.g.opencode_opts = {
    -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
}

-- Required for `opts.auto_reload`.
--
vim.o.autoread = true

-- Recommended/example keymaps.
vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end,
    { desc = "Ask opencode" })

vim.keymap.set({ "n", "x" }, "<leader>oc", function() require("opencode").select() end,
    { desc = "Execute opencode action…" })

vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").prompt("@this") end,
    { desc = "Add to opencode" })
