local Logger = {}
Logger.__index = Logger

Logger.levels = {
	TRACE = vim.log.levels.TRACE,
	DEBUG = vim.log.levels.DEBUG,
	INFO = vim.log.levels.INFO,
	WARN = vim.log.levels.WARN,
	ERROR = vim.log.levels.ERROR,
}

Logger.level_names = {
	[Logger.levels.TRACE] = "TRACE",
	[Logger.levels.DEBUG] = "DEBUG",
	[Logger.levels.INFO] = "INFO",
	[Logger.levels.WARN] = "WARN",
	[Logger.levels.ERROR] = "ERROR",
}

-- Global state
Logger.commands_registered = false
Logger.global_level = Logger.levels.DEBUG

---@class Logger
---@field name string

---@class LoggerOptions
---@field name? string

---@param opts? LoggerOptions
---@return Logger
function Logger:new(opts)
	opts = opts or {}

	local obj = {
		name = opts.name or "Logger",
	}

	return setmetatable(obj, self)
end

---@param level integer
function Logger.set_global_level(level)
	Logger.global_level = level
end

---@return integer
function Logger.get_global_level()
	return Logger.global_level
end

---@param level string
function Logger.set_global_level_by_name(level)
	level = string.upper(level)

	local value = Logger.levels[level]

	if not value then
		return false
	end

	Logger.global_level = value

	return true
end

---@param level integer
function Logger:log(level, ...)
	if level < Logger.global_level then
		return
	end

	local parts = {}

	for i = 1, select("#", ...) do
		local value = select(i, ...)

		if type(value) == "table" then
			parts[#parts + 1] = vim.inspect(value)
		else
			parts[#parts + 1] = tostring(value)
		end
	end

	local timestamp = os.date("%Y-%m-%d %H:%M:%S")
	local level_name = Logger.level_names[level] or "UNKNOWN"

	local message = string.format("%s [%s] [%s] %s", timestamp, level_name, self.name, table.concat(parts, " "))

	vim.notify(message, level)
end

function Logger:trace(...)
	self:log(Logger.levels.TRACE, ...)
end

function Logger:debug(...)
	self:log(Logger.levels.DEBUG, ...)
end

function Logger:info(...)
	self:log(Logger.levels.INFO, ...)
end

function Logger:warn(...)
	self:log(Logger.levels.WARN, ...)
end

function Logger:error(...)
	self:log(Logger.levels.ERROR, ...)
end

--- Register commands for changing the logger level
function Logger:register_commands()
	if Logger.commands_registered then
		return
	end

	vim.api.nvim_create_user_command("LoggerLevel", function(opts)
		local ok = Logger.set_global_level_by_name(opts.args)

		if ok then
			vim.notify("Logger level changed to " .. opts.args)
		else
			vim.notify("Invalid logger level: " .. opts.args, vim.log.levels.ERROR)
		end
	end, {
		nargs = 1,
		complete = function()
			return vim.tbl_keys(Logger.levels)
		end,
	})

	Logger.commands_registered = true
end

return Logger
