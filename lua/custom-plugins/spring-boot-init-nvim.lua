local logger = require("utils.logger"):new({ name = "custom-plugins.spring-boot-init-nvim" })

logger:debug("Loading custom-plugins.spring-boot-init-nvim...")

local M = {}

---@param value string
---@return string
local function shellescape(value)
	return vim.fn.shellescape(value)
end

---@param name string
local function create_project(name)
	name = vim.trim(name)

	if name == "" then
		vim.notify("Project name cannot be empty", vim.log.levels.ERROR)
		return
	end

	if vim.fn.isdirectory(name) == 1 or vim.fn.filereadable(name) == 1 then
		vim.notify("'" .. name .. "' already exists", vim.log.levels.ERROR)
		return
	end

	local package_name = "com.example." .. name:gsub("[^%w]", ""):lower()

	local command = table.concat({
		"curl --fail --silent --show-error -G",
		"https://start.spring.io/starter.zip",
		"--data-urlencode " .. shellescape("type=gradle-project"),
		"--data-urlencode " .. shellescape("language=java"),
		"--data-urlencode " .. shellescape("groupId=com.example"),
		"--data-urlencode " .. shellescape("artifactId=" .. name),
		"--data-urlencode " .. shellescape("name=" .. name),
		"--data-urlencode " .. shellescape("packageName=" .. package_name),
		"--data-urlencode " .. shellescape("javaVersion=26"),
		"--data-urlencode " .. shellescape("dependencies=web,devtools,lombok"),
		"-o " .. shellescape(name .. ".zip"),
		"&& mkdir " .. shellescape(name),
		"&& unzip -q " .. shellescape(name .. ".zip") .. " -d " .. shellescape(name),
		"&& rm " .. shellescape(name .. ".zip"),
	}, " ")

	vim.notify("Creating Spring Boot project: " .. name)

	vim.system({ "sh", "-c", command }, { text = true }, function(result)
		vim.schedule(function()
			if result.code ~= 0 then
				vim.notify("Failed to create project:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
				return
			end

			local project_path = vim.fn.getcwd() .. "/" .. name

			vim.notify("Created Spring Boot project: " .. project_path)
			vim.cmd.cd(vim.fn.fnameescape(project_path))
			vim.cmd.edit(
				"src/main/java/"
					.. package_name:gsub("%.", "/")
					.. "/"
					.. name:gsub("^%l", string.upper)
					.. "Application.java"
			)
		end)
	end)
end

function M.setup()
	vim.api.nvim_create_user_command("SpringNew", function()
		vim.ui.input({
			prompt = "Project name: ",
			default = "demo",
		}, function(name)
			if name then
				create_project(name)
			end
		end)
	end, {
		desc = "Create a Spring Boot project",
	})
end

M.setup()

return M
