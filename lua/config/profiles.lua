local M = {}

M.profiles = {
	classic = { core = true, git = true, extra = true, ["42"] = false},
	light     = { core = true, git = true, extra = false, ["42"] = false},
	["42"]      = { core = true,  git = true, extra = true, ["42"] = true},
	["42_light"]= { core = true,  git = true, extra = false, ["42"] = true},
}

M.order = { "classic", "light", "42", "42_light", "custom" }

return M
