local	categories = require("config.categories")

return {
	'nvim-treesitter/nvim-treesitter',
	enabled = categories.is_enabled("core"),
	lazy = false,
	build = ':TSUpdate'
}
