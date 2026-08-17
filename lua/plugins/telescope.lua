local	categories = require("config.categories")

return {
	{
		'nvim-telescope/telescope.nvim', version = '*',
		enabled = categories.is_enabled("core"),
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			{ 'nvim-telescope/telescope-ui-select.nvim' },
		}
	},
}
