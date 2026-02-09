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
local c = ls.choice_node
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

-- vim.keymap.set({ "i", "s" }, "<C-j>", function()
--     if ls.choice_active() then
--         ls.change_choice(1)
--     end
-- end)

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

-- Returns the current date and time in ISO 8601 format
-- Date only (local)
local function today()
	return os.date("%Y-%m-%d")
end

-- Time only (local)
local function now_time()
	return os.date("%H:%M:%S")
end

-- Human-readable local datetime
local function now_local()
	return os.date("%Y-%m-%d %H:%M:%S")
end

-- ISO-8601–like local datetime (no timezone)
-- Used by Obsidian frontmatter (de facto convention)
local function now_obsidian()
	return os.date("%Y-%m-%dT%H:%M:%S")
end

-- True ISO 8601 / RFC 3339 (UTC)
local function now_iso_utc()
	return os.date("!%Y-%m-%dT%H:%M:%SZ")
end

-- Unix timestamp (seconds since epoch)
local function now_unix()
	return tostring(os.time())
end

-- Filename-safe timestamp (sortable)
local function now_filename()
	return os.date("%Y%m%d-%H%M%S")
end

local function gen_code_block(lang)
	return s(
		{
			trig = lang,
			name = "Codeblock",
			desc = lang .. " codeblock",
		},
		fmt(
			[[
```{}
{}
```
]],
			{ lang, i(0) }
		)
	)
end

-- Get the system clipboard
local function clipboard()
	return vim.fn.getreg("+")
end

local function clipboard_choices(n)
	local choices = {}
	for i = 0, n - 1 do
		local clip = vim.fn.getreg("+", i)
		if clip ~= "" then
			table.insert(choices, clip)
		end
	end
	return choices
end

-- Go Snippets --
ls.add_snippets("go", {

	s(
		"main",
		fmt(
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
		)
	),

	s(
		"struct",
		fmt(
			[[
        type {} struct {{
            {}
        }}
        ]],
			{
				i(1, "Struct"),
				i(0),
			}
		)
	),

	s(
		"method",
		fmt(
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
		)
	),

	-- create a struct and its method snippet
	s(
		"stm",
		fmt(
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
		)
	),

	s(
		"iferr",
		fmt(
			[[
        if err := {}; err != nil {{
            return err
        }}
        ]],
			{
				i(1, "<some operation>"),
			}
		)
	),
	s(
		"sig",
		fmt(
			[[
    sigCh := make(chan os.Signal, 1)
    signal.Notify(sigCh, os.Interrupt)
    <-sigCh
    ]],
			{}
		)
	),
	s(
		"tick",
		fmt(
			[[
    ticker := time.NewTicker({} * time.Second)
    defer ticker.Stop()

    for {{
        select {{
        case <-ticker.C:
            {}
        }}
    }}
    ]],
			{
				i(1, "2"),
				i(0, "// do something"),
			}
		)
	),
	s(
		"conso",
		fmt(
			[[
        type {}Options struct {{
            {}
        }}

        func New{}(options {}Options) (*{}, error) {{
            return &{}{{}}, nil
        }}
        ]],
			{
				i(1, "Struct"),
				i(2, "// options"),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
			}
		)
	),
})

-- TypeScript Snippets --
ls.add_snippets("typescript", {

	s("clg", {
		t("console.log("),
		i(1, "message"),
		t(");"),
	}),

	s("func", {
		t("function "),
		i(1, "functionName"),
		t("("),
		i(2, "params"),
		t("): "),
		i(3, "returnType"),
		t(" {"),
		t({ "", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	s("cl", {
		t("class "),
		i(1, "ClassName"),
		t(" {"),
		t({ "", "\tconstructor(" }),
		i(2, "params"),
		t(") {"),
		t({ "", "\t\t" }),
		i(0),
		t({ "", "\t}" }),
		t({ "", "}" }),
	}),

	s("imp", {
		t("import "),
		i(1, "{ ModuleName }"),
		t(" from '"),
		i(2, "module-path"),
		t("';"),
	}),
})

-- Typescirpt React Snippets --
ls.add_snippets("typescriptreact", {
	s("clg", {
		t("console.log("),
		i(1, "message"),
		t(");"),
	}),
	s(
		"rf",
		fmt(
			[[
        import React from "react";

        interface Props {{}};

        export const {}: React.FC<Props> = (props) => {{
          const {{ {} }} = props;
          return (<>{}</>);
        }}
        ]],
			{
				i(1, "ComponentName"), -- 1 export name
				i(2), -- 2 destructured props
				f(function(args) -- 3 repeat component name
					return args[1][1]
				end, { 1 }),
			}
		)
	),
})

-- Markdown Snippets --
local programmning_languages = {
	"bash",
	"go",
	"lua",
	"javascript",
	"typescript",
	"swift",
	"c",
	"cpp",
	"json",
	"dockerfile",
	"html",
	"css",
	"markdown",
	"sql",
	"txt",
	"regex",
	"yaml",
	"java",
	"python",
	"php",
}

ls.add_snippets("markdown", {
	s("img", fmt("![{}]({})", { i(1, "alt text"), i(2, "image url") })),

	s(
		"codeblock",
		fmt(
			[[
        ```{}
        {}
        ```
        ]],
			{ i(1, "language"), i(0) }
		)
	),

	s(
		"table",
		fmt(
			[[
        | {} | {} |
        |---|---|
        | {} | {} |
        | {} | {} |
        ]],
			{ i(1, "Header1"), i(2, "Header2"), i(3, "Row1Col1"), i(4, "Row1Col2"), i(5, "Row2Col1"), i(6, "Row2Col2") }
		)
	),

	s("list", fmt("- {}", { i(1, "List item") })),

	s("numlist", fmt("1. {}", { i(1, "List item") })),

	s("todo", fmt("- [ ] {}", { i(1, "Task item") })),

	-- toggleable header
	s(
		"toggle",
		fmt(
			[[
        <details>
        <summary>{}</summary>

        {}

        </details>
    ]],
			{
				i(1, "title"),
				i(0, "content"),
			}
		)
	),

	s(
		"note",
		fmt(
			[[
        ---
        id:
          "{}":
        aliases:
        tags:
          - daily
        created:
          "{}":
        updated:
          "{}":
        ---

        # Note

        - {}

        # Todos

        - [ ] todo1
]],
			{
				f(now_obsidian),
				f(now_obsidian),
				f(now_obsidian),
				i(1, "note 1"),
			}
		)
	),

	-- Markdown link snippet from clipboard
	s(
		"link",
		fmt(
			[[
        [{}]({})
    ]],
			{
				i(1, "text"), -- Placeholder for link text
				f(clipboard, {}), -- Insert clipboard contents as URL
			}
		)
	),

	-- README template snippet
	s(
		"readme",
		fmt(
			[[
        # {}

        {}

        ## Table of contents
        - [Installation](#installation)

        ## Installation

        {}

    ]],
			{
				i(1, "Title"),
				i(2, "Description"),
				i(3, "Installation instructions"),
			}
		)
	),
})
ls.add_snippets("markdown", vim.tbl_map(gen_code_block, programmning_languages))

-- Json Snippets --
ls.add_snippets("json", {
	s("obj", {
		t("{"),
		t({ "", '\t"' }),
		i(1, "key"),
		t('": '),
		i(2, "value"),
		t({ "", "}" }),
	}),

	s("arr", {
		t("["),
		t({ "", "\t" }),
		i(1, "value1"),
		t({ ",", "\t" }),
		i(2, "value2"),
		t({ "", "]" }),
	}),
})

-- All Snippets --
ls.add_snippets("all", {
	s("now_date", {
		f(today),
	}),

	s("now_time", {
		f(now_time),
	}),

	s("now_datetime", {
		f(now_local),
	}),

	s("now_obsidian", {
		f(now_obsidian),
	}),

	s("now_utc", {
		f(now_iso_utc),
	}),

	s("now_unix", {
		f(now_unix),
	}),

	s("now_filename", {
		f(now_filename),
	}),
})

-- lua
local function get_clipboard_url()
	local text = vim.fn.getreg("+") or ""
	if text:match("^https?://") or text:match("^www%.") then
		return text
	else
		return "" -- fallback to insert node
	end
end

ls.add_snippets("lua", {
	s(
		"vap",
		fmt(
			[[
vim.pack.add({{
    {{ src = "{}" }},
}})
            ]],
			{
				f(get_clipboard_url, {}), -- will use clipboard if it's a URL
			}
		)
	),
})
-- Load VSCode-style snippets from a custom directory
-- NOTE: Disabled for archive purposes, enable if needed
-- local luasnipvscode = require("luasnip.loaders.from_vscode")
-- luasnipvscode.lazy_load({ paths = { "~/.config/nvim/src/lua/native/lsp/snippets/" } })
