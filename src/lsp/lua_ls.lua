return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    -- Nested lists is easul priority
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {},
}
