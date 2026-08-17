local	categories = require("config.categories")

return {
	"luckasRanarison/nvim-devdocs",
	enabled = categories.is_enabled("extra"),
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function ()
		require('nvim-devdocs').setup({
			after_open = function(bufnr)
				vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Esc>', ':close<CR>', {})
			end
		})
	end
}
