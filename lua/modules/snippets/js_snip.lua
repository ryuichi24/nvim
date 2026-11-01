local logger = require("utils.logger"):new({ name = "modules.snippets.js_snip" })

logger:debug("Loading modules.snippets.js_snip...")

local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local i = ls.insert_node

ls.add_snippets("javascript", {
	s(
		"api",
		fmta(
			[[
// Install: npm install express
// Run: node server.cjs (save this file as server.cjs)
const express = require("express");
const { randomUUID } = require("node:crypto");

const app = express();
const port = process.env.PORT || <>;
// Todos are stored in memory and reset when the server restarts.
const todos = new Map();

for (const seed of [
	{ title: "Learn Express", completed: true },
	{ title: "Build a Todo API", completed: false },
	{ title: "Write API tests", completed: false },
]) {
	const todo = { id: randomUUID(), ...seed };
	todos.set(todo.id, todo);
}

app.use(express.json());

app.get("/todos", (req, res) =>> {
	res.json([...todos.values()]);
});

app.post("/todos", (req, res) =>> {
	const { title, completed = false } = req.body || {};
	if (typeof title !== "string" || !title.trim()) {
		return res.status(400).json({ error: "title must be a non-empty string" });
	}
	if (typeof completed !== "boolean") {
		return res.status(400).json({ error: "completed must be a boolean" });
	}

	const todo = { id: randomUUID(), title: title.trim(), completed };
	todos.set(todo.id, todo);
	res.location(`/todos/${todo.id}`).status(201).json(todo);
});

app.param("id", (req, res, next, id) =>> {
	const todo = todos.get(id);
	if (!todo) {
		return res.status(404).json({ error: "Todo not found" });
	}
	req.todo = todo;
	next();
});

app.get("/todos/:id", (req, res) =>> {
	res.json(req.todo);
});

app.patch("/todos/:id", (req, res) =>> {
	const { title, completed } = req.body || {};
	if (title === undefined && completed === undefined) {
		return res.status(400).json({ error: "Provide title or completed" });
	}
	if (title !== undefined && (typeof title !== "string" || !title.trim())) {
		return res.status(400).json({ error: "title must be a non-empty string" });
	}
	if (completed !== undefined && typeof completed !== "boolean") {
		return res.status(400).json({ error: "completed must be a boolean" });
	}

	if (title !== undefined) req.todo.title = title.trim();
	if (completed !== undefined) req.todo.completed = completed;
	res.json(req.todo);
});

app.delete("/todos/:id", (req, res) =>> {
	todos.delete(req.todo.id);
	res.sendStatus(204);
});

app.use((req, res) =>> {
	res.status(404).json({ error: "Route not found" });
});

app.use((err, req, res, next) =>> {
	if (res.headersSent) return next(err);
	if (err.type === "entity.parse.failed") {
		return res.status(400).json({ error: "Invalid JSON body" });
	}
	if (err.status === 413) {
		return res.status(413).json({ error: "Request body too large" });
	}
	console.error(err);
	res.status(500).json({ error: "Internal server error" });
});

app.listen(port, () =>> {
	console.log(`Todo API listening on http://localhost:${port}`);
});
<>
]],
			{ i(1, "3000"), i(0) }
		)
	),
	s("clg", fmta("console.log(<>);", { i(1, "message") })),
	s("im", fmta('import { <> } from "<>";', { i(2, "item"), i(1, "path") })),
	s("imd", fmta('import <> from "<>";', { i(2, "module"), i(1, "path") })),
	s("ex", fmta('export * from "<>";', { i(1, "path") })),
	s(
		"func",
		fmta(
			[[
function <>(<>) {
	<>
}
]],
			{ i(1, "functionName"), i(2, "params"), i(0) }
		)
	),
	s(
		"af",
		fmta(
			[[
const <> = (<>) =>> {
	<>
};
]],
			{ i(1, "functionName"), i(2, "params"), i(0) }
		)
	),
	s(
		"async",
		fmta(
			[[
async function <>(<>) {
	<>
}
]],
			{ i(1, "functionName"), i(2, "params"), i(0) }
		)
	),
	s(
		"forof",
		fmta(
			[[
for (const <> of <>) {
	<>
}
]],
			{ i(1, "item"), i(2, "items"), i(0) }
		)
	),
	s(
		"try",
		fmta(
			[[
try {
	<>
} catch (error) {
	<>
}
]],
			{ i(1), i(0, "console.error(error);") }
		)
	),
	s(
		"cl",
		fmta(
			[[
class <> {
	constructor(<>) {
		<>
	}
}
]],
			{ i(1, "ClassName"), i(2, "params"), i(0) }
		)
	),
})
