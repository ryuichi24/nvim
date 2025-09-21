vim.pack.add({
    { src = "https://github.com/github/copilot.vim" },
    -- https://copilotc-nvim.github.io/CopilotChat.nvim/#/?id=vim-plug
    { src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim" }
})

-- GitHub Copilot Settings
vim.api.nvim_set_keymap('i', '<M-CR>', 'copilot#Accept("<CR>")',
    { expr = true, noremap = true, silent = true })

vim.g.copilot_no_tab_map = true

vim.g.copilot_filetypes = {
    ["*"] = true,        -- Enable for all filetypes
    ["markdown"] = true, -- Disable for markdown files
}

-- CopilotChat Settings
vim.keymap.set('n', '<leader>cc', '<cmd>CopilotChat<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cx', '<cmd>CopilotChatClose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>cr', '<cmd>CopilotChatReset<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>ce', '<cmd>CopilotChatExplain<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>cf', '<cmd>CopilotChatFix<CR>', { noremap = true, silent = true })


require("CopilotChat").setup({
    model = "claude-sonnet-4", -- AI model to use
    temperature = 0.1,         -- Lower = focused, higher = creative
    window = {
        layout = "vertical",   -- 'vertical', 'horizontal', 'float'
        width = 0.3,           -- 50% of screen width
    },
    auto_insert_mode = true,   -- Enter insert mode when opening,
    mappings = {
        reset = false,
    }
})
