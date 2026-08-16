local	categories = require("config.categories")

return {
	'nvim-telescope/telescope.nvim', version = '*',
	enabeled = categories.is_enabled("core"),
	dependencies = {
		'nvim-lua/plenary.nvim',
		-- optional but recommended
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	}
}
