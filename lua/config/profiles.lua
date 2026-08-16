local M = {}

M.profiles = {
	classic = { core = true, LSP = true, Ui = true, editor = true, git = true, extra = true, ["42"] = false},
	light     = { core = true, LSP = false, Ui = false, editor = false, git = true, extra = false, ["42"] = false},
	["42"]      = { core = true, LSP = true, Ui = true, editor = true, git = true, extra = true, ["42"] = true},
	["42_light"]= { core = true, LSP = false, Ui = false, editor = false, git = true, extra = false, ["42"] = true},
}

M.order = { "classic", "light", "42", "42_light", "custom" }

return M
