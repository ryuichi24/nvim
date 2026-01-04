vim.pack.add({
    -- Code Snippet
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    -- snippet engine
    { src = "https://github.com/L3MON4D3/LuaSnip" },
})

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local extras = require("luasnip.extras")
local rep = extras.rep
-- {{  → literal {
-- }}  → literal }
-- {}  → placeholder
local fmt = require("luasnip.extras.fmt").fmt


-- config --
ls.config.set_config({
    history = true,
    -- so you can see snippets as you type
    updateevents = "TextChanged,TextChangedI",
})


-- Keybindings --
vim.keymap.set({ "i", "s" }, "<A-j>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<A-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

vim.keymap.set("i", "<A-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

-- Go Snippets --

-- util functions --
-- Returns the first character of the last PascalCase part of a string, lowercased
local function receiver_from_struct(node_index)
    return f(function(args)
        local struct_name = args[1][1] or ""
        local parts = {}
        for part in struct_name:gmatch("[A-Z][a-z0-9]*") do
            table.insert(parts, part)
        end
        local last = parts[#parts] or struct_name
        return last:sub(1, 1):lower()
    end, { node_index })
end

ls.add_snippets("go", {

    s("main", fmt(
        [[
        package main

        import (
            "fmt"
        )

        func main() {{
            {}
        }}
        ]],
        {
            i(1, 'fmt.Println("Hello, World!")'),
        }
    )),

    s("struct", fmt(
        [[
        type {} struct {{
            {}
        }}
        ]],
        {
            i(1, "Struct"),
            i(0),
        }
    )),

    s("method", fmt(
        [[
        func ({} *{}) {}() {} {{
            {}
        }}
        ]],
        {
            receiver_from_struct(1),
            i(1, "Struct"),
            i(2, "Method"),
            i(3, "error"),
            i(0, "return nil"),
        }
    )),

    -- create a struct and its method snippet
    s("stm", fmt(
        [[
        type {} struct {{
            {}
        }}

        func ({} *{}) {}() {} {{
            {}
        }}
        ]],
        {
            i(1, "Struct"),
            i(2, "Field"),
            receiver_from_struct(1),
            rep(1),
            i(3, "Method"),
            i(4, "error"),
            i(0, "return nil"),
        }
    ))
})

-- TypeScript Snippets --
ls.add_snippets("typescript", {

    s("clg", {
        t("console.log("), i(1, "message"), t(");"),
    }),

    s("func", {
        t("function "), i(1, "functionName"), t("("), i(2, "params"), t("): "), i(3, "returnType"), t(" {"),
        t({ "", "\t" }), i(0),
        t({ "", "}" }),
    }),

    s("cl", {
        t("class "), i(1, "ClassName"), t(" {"),
        t({ "", "\tconstructor(" }), i(2, "params"), t(") {"),
        t({ "", "\t\t" }), i(0),
        t({ "", "\t}" }),
        t({ "", "}" }),
    }),

    s("imp", {
        t("import "), i(1, "{ ModuleName }"), t(" from '"), i(2, "module-path"), t("';"),
    }),

})

-- Typescirpt React Snippets --
ls.add_snippets("typescriptreact", {
    s("clg", {
        t("console.log("), i(1, "message"), t(");"),
    }),
})


-- Markdown Snippets --
ls.add_snippets("markdown", {

    s("link", {
        t("["), i(1, "link text"), t("]("), i(2, "url"), t(")"),
    }),

    s("img", {
        t("!["), i(1, "alt text"), t("]("), i(2, "image url"), t(")"),
    }),

    s("codeblock", {
        t("```"), i(1, "language"),
        t({ "", "" }),
        i(0),
        t({ "", "```" }),
    }),

    s("table", {
        t("| "), i(1, "Header1"), t(" | "), i(2, "Header2"), t(" |"),
        t({ "", "|---|---|" }),
        t({ "", "| " }), i(3, "Row1Col1"), t(" | "), i(4, "Row1Col2"), t(" |"),
        t({ "", "| " }), i(5, "Row2Col1"), t(" | "), i(6, "Row2Col2"), t(" |"),
    }),

    s("list", {
        t("- "), i(1, "List item"),
    }),

    s("numlist", {
        t("1. "), i(1, "List item"),
    }),

    s("todo", {
        t("- [ ] "), i(1, "Task item"),
    }),

})

-- Json Snippets --
ls.add_snippets("json", {
    s("obj", {
        t("{"),
        t({ "", '\t"' }), i(1, "key"), t('": '), i(2, "value"), t({ "", "}" }),
    }),

    s("arr", {
        t("["),
        t({ "", "\t" }), i(1, "value1"), t({ ",", "\t" }), i(2, "value2"), t({ "", "]" }),
    }),

})

-- All Snippets --
ls.add_snippets("all", {
    s("date", {
        t(os.date("%Y-%m-%d")),
    }),

    s("time", {
        t(os.date("%H:%M:%S")),
    }),

    s("datetime", {
        t(os.date("%Y-%m-%d %H:%M:%S")),
    }),
})

-- Load VSCode-style snippets from a custom directory
-- NOTE: Disabled for archive purposes, enable if needed
-- local luasnipvscode = require("luasnip.loaders.from_vscode")
-- luasnipvscode.lazy_load({ paths = { "~/.config/nvim/src/lua/native/lsp/snippets/" } })
