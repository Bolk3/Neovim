local M = {}
local profiles = require("config.profiles")

local state_file = vim.fn.stdpath("data") .. "/categories.json"

M.modes = {"core", "LSP", "Ui", "git", "extra", "42"}

local function	default_data()
	local	custom = {}
	for _, m in ipairs(M.modes) do
		custom[m] = true
	end
	return { profile = "classic", custom = custom }
end

local function	load_data()
	local	f = io.open(state_file, "r")
	if f then
		local	content = f:read("*a")
		f:close()
		local	ok, data = pcall(vim.json.decode, content)
		if ok and data and data.profile and data.custom then
			return data
		end
	end
	return default_data()
end

local function	save_data(data)
	local	f = io.open(state_file, "w")
	if f then
		f:write(vim.json.encode(data))
		f:close()
	end
end

M.data = load_data()

function	M.current_state()
	if M.data.profile == "custom" then
		return M.data.custom
	end
	return profiles.profiles[M.data.profile] or M.data.custom
end

function	M.is_enabled(mode)
	return M.current_state()[mode] == true
end

function	M.get_profile()
	return M.data.profile
end

function	M.set_profile(name)
	M.data.profile = name
	save_data(M.data)
end

function	M.toggle_custom(mode)
	M.data.custom[mode] = not M.data.custom[mode]
end

function	M.save()
	save_data(M.data)
end

return M
