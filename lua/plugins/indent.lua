local	categories = require("config.categories")

return {
	'nvim-mini/mini.indentscope',
	enabled = categories.is_enabled("Ui"),
	version = false,
	opts = {}
}
