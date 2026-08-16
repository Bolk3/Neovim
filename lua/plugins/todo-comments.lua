local	categories = require("config.categories")

return {
	"folke/todo-comments.nvim",
	enabled = categories.is_enabled("Ui"),
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
	}
}
