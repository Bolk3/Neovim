local	M = {}

local	env_path = vim.fn.stdpath("config") .. "/.env"
local	cache = nil

local	function parse_line(line)
	line = line:gsub("^%s+", ""):gsub("%s+$", "")
	if line == "" or line:sub(1, 1) == "#" then
		return nil
	end
	local	key, value = line:match("^([%w_]+)%s*=%s*(.*)$")
	if not key then
		return nil
	end
	value = value:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1")
	return key, value
end

local function	load()
	if cache then
		return cache
	end
	cache = {}

	local	f = io.open(env_path, "r")
	if not f then
		return cache
	end

	for line in f:lines() do
		local	key, value = parse_line(line)
		if key then
			cache[key] = value
		end
	end
	f:close()

	return cache
end

function	M.get(key, default)
	local	data = load()
	local	value = data[key]
	if value == nil or value == "" then
		return default
	end
	return value
end

function	M.reload()
	cache = nil
	return load()
end

function	M.get_path(key, default)
	local value = M.get(key, default)
	if not value then
		return nil
	end
	return vim.fn.expand(value)
end

return M
