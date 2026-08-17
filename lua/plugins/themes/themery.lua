local categories = require("config.categories")
return {
	"zaldih/themery.nvim",
	enabled = categories.is_enabled("themes"),
	lazy = false,
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		require("themery").setup({
			livePreview = true,
			themes = {
				{ name = "Github Dark", colorscheme = "github_dark" },
				{ 
					name = "Github Dark (transprent)",
					colorscheme = "github_dark",
					before = [[
					require("github-theme").setup {
						options = { transparent = true }
					}
					]]
				},
				{ name = "Github Dark Default", colorscheme = "github_dark_default" },
				{ 
					name = "Github Dark Default (transprent)",
					colorscheme = "github_dark_default",
					before = [[
					require("github-theme").setup {
						options = { transparent = true }
					}
					]]
				},
				{ name = "Github Dark Dimmed", colorscheme = "github_dark_dimmed" },
				{ 
					name = "Github Dark Dimmed (transprent)",
					colorscheme = "github_dark_dimmed",
					before = [[
					require("github-theme").setup {
						options = { transparent = true }
					}
					]]
				},
				{ name = "Github Dark High Contrast", colorscheme = "github_dark_high_contrast" },
				{ 
					name = "Github Dark High Contrast (transprent)",
					colorscheme = "github_dark_high_contrast",
					before = [[
					require("github-theme").setup {
						options = { transparent = true }
					}
					]]
				},
				{ name = "Github Light", colorscheme = "github_light" },
				{ 
					name = "Github Light (transprent)",
					colorscheme = "github_light",
					before = [[
					require("github-theme").setup {
						options = { transparent = true }
					}
					]]
				},
				{ name = "Github Light Default", colorscheme = "github_light_default" },
				{ 
					name = "Github Light Default (transprent)",
					colorscheme = "github_light_default",
					before = [[
					require("github-theme").setup {
						options = { transparent = true }
					}
					]]
				},
				{ name = "Github Light High Contrast", colorscheme = "github_light_high_contrast" },
				{ 
					name = "Github Light High Contrast (transprent)",
					colorscheme = "github_light_high_contrast",
					before = [[
					require("github-theme").setup {
						options = { transparent = true }
					}
					]]
				},
				{ name = "Suannhai Jifuen", colorscheme = "suannhai-jifuen"},
				{ name = "Suannhai Lam-ni", colorscheme = "suannhai-lam-ni"},
				{ name = "Suannhai Hue-poo", colorscheme = "suannhai-hue-poo"},
				{ name = "Suannhai Rouiro", colorscheme = "suannhai-rouiro"},
				{ name = "Suannhai Sumi", colorscheme = "suannhai-sumi"},
				{ name = "Suannhai Koiai", colorscheme = "suannhai-koiai"},
				{ name = "Suannhai Torinoko", colorscheme = "suannhai-torinoko"},
				{ name = "Suannhai Shironeri", colorscheme = "suannhai-shironeri"},
			},
		})
	end,
}
