local	categories = require("config.categories")

return {
	{
		'saghen/blink.cmp',
		dependencies = { 'rafamadriz/friendly-snippets' },
		enabled = categories.is_enabled("LSP"),
		version = '1.*',
		opts = {
			keymap = { preset = 'default' },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},

			completion = {
				menu = {
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									return require('lspkind').symbol_map[ctx.kind] or ''
								end,
							},
						},
					},
				},
			},

			signature = { enabled = true },
		},
	},
	{
		"onsails/lspkind.nvim",
		enabled = categories.is_enabled("LSP"),
	}
}
