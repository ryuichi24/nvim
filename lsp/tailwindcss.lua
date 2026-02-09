--- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/tailwindcss.lua
---@brief
--- https://github.com/tailwindlabs/tailwindcss-intellisense
---
--- Tailwind CSS Language Server can be installed via npm:
---
---@type vim.lsp.Config
return {
	cmd = { "tailwindcss-language-server", "--stdio" },

	filetypes = {
		-- html
		"aspnetcorerazor",
		"astro",
		"astro-markdown",
		"blade",
		"clojure",
		"django-html",
		"htmldjango",
		"edge",
		"eelixir",
		"elixir",
		"ejs",
		"erb",
		"eruby",
		"gohtml",
		"gohtmltmpl",
		"haml",
		"handlebars",
		"hbs",
		"html",
		"htmlangular",
		"html-eex",
		"heex",
		"jade",
		"leaf",
		"liquid",
		"markdown",
		"mdx",
		"mustache",
		"njk",
		"nunjucks",
		"php",
		"razor",
		"slim",
		"twig",
		-- css
		"css",
		"less",
		"postcss",
		"sass",
		"scss",
		"stylus",
		"sugarss",
		-- js
		"javascript",
		"javascriptreact",
		"reason",
		"rescript",
		"typescript",
		"typescriptreact",
		-- mixed
		"vue",
		"svelte",
		"templ",
	},

	capabilities = {
		workspace = {
			didChangeWatchedFiles = { dynamicRegistration = true },
		},
	},

	settings = {
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				invalidConfigPath = "error",
				invalidTailwindDirective = "error",
				recommendedVariantOrder = "warning",
			},
			classAttributes = {
				"class",
				"className",
				"class:list",
				"classList",
				"ngClass",
			},
			includeLanguages = {
				eelixir = "html-eex",
				elixir = "phoenix-heex",
				eruby = "erb",
				heex = "phoenix-heex",
				htmlangular = "html",
				templ = "html",
			},
		},
	},

	before_init = function(_, config)
		config.settings = config.settings or {}
		config.settings.editor = config.settings.editor or {}
		config.settings.editor.tabSize = config.settings.editor.tabSize or vim.lsp.util.get_effective_tabstop()
	end,

	workspace_required = true,

	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)

		-- base markers
		local root_files = {
			-- Generic
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.cjs",
			"postcss.config.mjs",
			"postcss.config.ts",
			-- Django
			"theme/static_src/tailwind.config.js",
			"theme/static_src/tailwind.config.cjs",
			"theme/static_src/tailwind.config.mjs",
			"theme/static_src/tailwind.config.ts",
			"theme/static_src/postcss.config.js",
		}

		-- 1️⃣ package.json dependency check (replacement for insert_package_json)
		local pkg_root = vim.fs.root(fname, { "package.json" })
		if pkg_root then
			local pkg = pkg_root .. "/package.json"
			local ok, data = pcall(vim.fn.readfile, pkg)
			if ok then
				local json = vim.json.decode(table.concat(data, "\n"))
				local deps = vim.tbl_extend("force", json.dependencies or {}, json.devDependencies or {})
				if deps.tailwindcss then
					table.insert(root_files, "package.json")
				end
			end
		end

		-- 2️⃣ ecosystem locks that imply Tailwind usage
		local ecosystem_root = vim.fs.root(fname, { "mix.lock", "Gemfile.lock" })
		if ecosystem_root then
			table.insert(root_files, "mix.lock")
			table.insert(root_files, "Gemfile.lock")
		end

		-- 3️⃣ fallback (.git) — needed for Tailwind v4
		table.insert(root_files, ".git")

		local root = vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1])

		on_dir(root)
	end,
}
--- npm install -g @tailwindcss/language-server
