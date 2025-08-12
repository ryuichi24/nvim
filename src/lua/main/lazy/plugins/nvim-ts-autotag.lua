return {
    "windwp/nvim-ts-autotag",
    config = function()
        -- Configure nvim-ts-autotag plugin
        require('nvim-ts-autotag').setup({
            opts = {
                -- Defaults
                enable_close = true,           -- Auto close tags
                enable_rename = true,          -- Auto rename paired tag
                enable_close_on_slash = false, -- Auto close on trailing </
            },
            -- Also configure for specific file types
            filetypes = {
                'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
                'rescript',
                'xml',
                'php',
                'markdown',
                'astro', 'glimmer', 'handlebars', 'hbs'
            },
            skip_tags = {
                'area', 'base', 'br', 'col', 'command', 'embed', 'hr', 'img', 'input',
                'keygen', 'link', 'meta', 'param', 'source', 'track', 'wbr', 'menuitem'
            }
        })
    end
}
