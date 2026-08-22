local logger = require("utils.logger"):new({ name = "modules.snippets.go_snip" })

logger:debug("Loading modules.snippets.go_snip...")

local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep

ls.add_snippets("go", {
	s(
		"main",
		fmta(
			[[
package main

import (
	"fmt"
)

func main() {
	fmt.Println("<>")
}
		]],
			{
				i(0, "Hello World!"),
			}
		)
	),
	s(
		"hdl",
		fmta(
			[[
package <>

import (
	"encoding/json"
	"log/slog"
	"net/http"
)

type Handler struct {
	logger *slog.Logger
}

type Deps struct {
	Logger *slog.Logger
}

func New(deps Deps) *Handler {
	return &Handler{
		logger: deps.Logger,
	}
}

func (h *Handler) Handle<>(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	_ = json.NewEncoder(w).Encode(map[string]string{
		"message": "<>",
	})
}

	]],
			{
				f(function()
					return vim.fn.expand("%:p:h:t")
				end),
				i(1, "Hello"),
				rep(1),
			}
		)
	),
})
