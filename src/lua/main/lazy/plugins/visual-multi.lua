return {
    "mg979/vim-visual-multi",
    init = function()
        vim.g.VM_default_mappings = 0
        vim.g.VM_maps = {
            ["Find Under"] = ''
        }
        vim.g.VM_add_cursor_at_pos_no_mappings = 1


        local function visual_corsors_with_delay()
            vim.cmd('silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"')
            vim.cmd('sleep 200m')
            vim.cmd('silent! execute "normal! A"')
        end

        vim.keymap.set("n", "<leader>mm", "<Plug>(VM-Find-Under)<Tab>", { desc = "Start multiple cursors" })
        vim.keymap.set("n", "<leader>ma", "<Plug>(VM-Select-All)<Tab>", { desc = "Select all" })
        vim.keymap.set("n", "<leader>mr", "<Plug>(VM-Start-Regex-Search)", { desc = "Start regex search" })
        vim.keymap.set("n", "<leader>mm", "<Plug>(VM-Add-Cursor-At-Pos)", { desc = "Add cursor at pos" })
        vim.keymap.set("n", "<leader>md", "<Plug>(VM-Add-Cursor-Down)", { desc = "Add cursor down" })
        vim.keymap.set("v", "<leader>mv", visual_corsors_with_delay, { desc = "Visual Corsors" })
        vim.keymap.set("n", "<leader>mt", "<Plug>(VM-Toggle-Multiline)", { desc = "Toggle multiline" })
        vim.keymap.set("n", "<leader>mo", "<Plug>(VM-Toggle-Mappings)", { desc = "Toggle Mapping" })
    end,
}
