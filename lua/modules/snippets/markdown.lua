local logger = require("utils.logger"):new({ name = "modules.snippets.markdown" })

logger:debug("Loading modules.snippets.markdown...")

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local d = ls.dynamic_node
local sn = ls.snippet_node
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
		{ trig = "table:([1-9]%d*)x([1-9]%d*)", regTrig = true, hidden = true, name = "Markdown table" },
		d(1, function(_, parent)
			local columns = tonumber(parent.captures[1])
			local rows = tonumber(parent.captures[2])
			local nodes = {}
			local index = 1

			local function add_row(row)
				table.insert(nodes, t("| "))
				for column = 1, columns do
					local placeholder = row == 0 and ("Header" .. column) or ("Row" .. row .. "Col" .. column)
					table.insert(nodes, i(index, placeholder))
					table.insert(nodes, t(column == columns and " |" or " | "))
					index = index + 1
				end
			end

			add_row(0)
			table.insert(nodes, t({ "", "|" .. string.rep("---|", columns), "" }))
			for row = 1, rows do
				add_row(row)
				if row < rows then
					table.insert(nodes, t({ "", "" }))
				end
			end
			table.insert(nodes, i(0))
			return sn(nil, nodes)
		end)
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
