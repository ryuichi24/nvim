local logger = require("utils.logger"):new({ name = "modules.snippets.markdown" })

logger:debug("Loading modules.snippets.markdown...")

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function now_obsidian()
	return os.date("%Y-%m-%dT%H:%M:%S")
end

local function clipboard()
	return vim.fn.getreg("+")
end

local function gen_code_block(lang)
	return s(
		{ trig = lang, name = "Codeblock", desc = lang .. " codeblock" },
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

local programming_languages = {
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
id: "{}"
aliases: []
tags: ["daily"]
created: "{}"
updated: "{}"
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
ls.add_snippets("markdown", vim.tbl_map(gen_code_block, programming_languages))
