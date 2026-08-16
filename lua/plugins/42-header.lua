local	categories = require("config.categories")

return {
	"Diogo-ss/42-header.nvim",
	enable = categories.is_enabled("42"),
	cmd = { "Stdheader" },
	keys = { "<F1>" },
	opts = {
		default_map = true,
		auto_update = true,
	},
	config = function(_, opts)
		require("42header").setup(opts)
	end,
}
