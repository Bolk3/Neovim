local	categories = require("config.categories")

return {
	"mfussenegger/nvim-lint",
	enable = categories.is_enabled("LSP"),
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			make = { "checkmake" },
		}
	end,
}
