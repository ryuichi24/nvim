return {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
        vim.o.foldcolumn = '1' -- '0' is not bad
        vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        ufo = require('ufo')

        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d Lines'):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, 'MoreMsg' })
            return newVirtText
        end

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set('n', '<leader>uo', ufo.openAllFolds)
        vim.keymap.set('n', '<leader>uc', ufo.closeAllFolds)

        vim.opt.fillchars:append({
            foldopen = 'v',  -- Opened fold
            foldclose = '>', -- Closed fold
            foldsep = ' ',   -- Optional: clean separator
        })

        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end,
            fold_virt_text_handler = handler
        })
    end
}
