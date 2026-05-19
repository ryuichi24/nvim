---@class HTTP
local HTTP = {}
HTTP.__index = HTTP

function HTTP:new()
	local obj = {}
	setmetatable(obj, HTTP)
	return obj
end
