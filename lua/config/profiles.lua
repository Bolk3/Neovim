local M = {}

M.profiles = {
	classic = { core = true, git = true, extra = true},
	light     = { core = true, git = true, extra = false},
	["42"]      = { core = true,  git = true, extra = true},
	["42_light"]= { core = true,  git = true, extra = false},
}

M.order = { "classic", "light", "42", "42_light", "custom" }

return M
