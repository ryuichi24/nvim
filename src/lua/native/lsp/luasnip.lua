vim.pack.add({
    -- Code Snippet
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    -- snippet engine
    { src = "https://github.com/L3MON4D3/LuaSnip" },
})

-- Setup Code Snippet
local luasnip = require("luasnip.loaders.from_vscode")
luasnip.lazy_load({ paths = { "~/.config/nvim/src/lua/native/lsp/snippets/" } })

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep


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

ls.add_snippets("go", {

    s("main", {
        t({
            "package main",
            "",
            "import (",
            "\t\"fmt\"",
            ")",
            "",
            "func main() {",
            "\t",
        }),
        i(1, 'fmt.Println("Hello, World!")'),
        t({
            "",
            "}",
        }),
    }),

    s("struct", {
        t("type "), i(1, "StructName"), t(" struct {"),
        t({ "", "\t" }), i(0),
        t({ "", "}" }),
    }),

    s("method", {
        t("func ("), i(1, "this"), t(" *"), i(2, "StructType"), t(") "), i(3, "MethodName"), t("() "), i(4, "ReturnType"), t(" {"),
        t({ "", "\t" }), i(0),
        t({ "", "}" }),
    }),


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
