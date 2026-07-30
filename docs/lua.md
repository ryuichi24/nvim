```lua
print("=== Lua Truthiness Test ===")

local values = {
{ name = "nil", value = nil },
{ name = "false", value = false },
{ name = "true", value = true },
{ name = "0", value = 0 },
{ name = '"" (empty string)', value = "" },
{ name = "{} (table)", value = {} },
}

for \_, item in ipairs(values) do
if item.value then
print(item.name .. " -> truthy")
else
print(item.name .. " -> falsey")
end
end

```
