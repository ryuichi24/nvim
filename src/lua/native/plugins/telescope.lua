vim.pack.add({
    { src = "https://github.com/nvim-telescope/telescope.nvim" }
})

local function quickfix_replace(opts)
    opts = opts or {}

    local prefill =
        opts.find
        or vim.fn.getreg("/")
        or vim.fn.expand("<cword>")

    local find = vim.fn.input("Find: ", prefill)
    if find == "" then return end

    local replace = vim.fn.input("Replace with: ")
    if replace == "" then return end

    local flags = opts.flags or "g"

    -- Run replace + write
    vim.cmd(string.format(
        "cfdo %%s/\\V%s/%s/%s | update",
        vim.fn.escape(find, "/"),
        vim.fn.escape(replace, "/"),
        flags
    ))

    -- Close edited buffers safely
    for _, bufnr in ipairs(vim.fn.getqflist({ items = 0 }).items) do
        if vim.api.nvim_buf_is_loaded(bufnr.bufnr) then
            pcall(vim.cmd, "bd " .. bufnr.bufnr)
        end
    end

    -- Close quickfix window safely
    local qf_win = vim.fn.getqflist({ winid = 0 }).winid
    if qf_win ~= 0 and vim.api.nvim_list_wins()[1] ~= qf_win then
        pcall(vim.api.nvim_win_close, qf_win, true)
    end
end

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function telescope_qf_replace(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    if not picker then return end

    local query = picker:_get_prompt()

    -- Default <C-q> behavior
    actions.send_to_qflist(prompt_bufnr)
    actions.open_qflist(prompt_bufnr)

    vim.schedule(function()
        quickfix_replace({
            find = query,
        })
    end)
end

vim.keymap.set("n", "<leader>qr", quickfix_replace, {
    desc = "Replace everything in quickfix",
})


require("telescope").setup {
    defaults = {
        path_display = { "smart" },
        mappings = {
            i = {
                ["<C-r>"] = telescope_qf_replace,
            },
            n = {
                ["<C-r>"] = telescope_qf_replace,
            },
        },
    },
    pickers = {
        find_files = {
            theme = "ivy",
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git" }
        }
    }
}

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Find recent files" })
vim.keymap.set("n", "<leader>fs", ":Telescope live_grep<CR>", { desc = "Find string in cwd" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fc", function()
        require("telescope.builtin").find_files {
            cwd = vim.fn.stdpath("config")
        }
    end,
    { desc = "Find files in neovim config dir" })
