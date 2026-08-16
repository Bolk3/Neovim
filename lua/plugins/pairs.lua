local	categories = require("config.categories")

return {
	'nvim-mini/mini.pairs',
	enabled = categories.is_enabled("editor"),
	version = '*',
	opts = {}
}
