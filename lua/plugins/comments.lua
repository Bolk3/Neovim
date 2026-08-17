local	categories = require("config.categories")

return {
	'numToStr/Comment.nvim',
	enabled = categories.is_enabled("editor"),
	opts = {
		-- add any options here
	}
}
