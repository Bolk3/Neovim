local	categories = require("config.categories")

return {
	"atiladefreitas/dooing",
	config = function()
		require("dooing").setup({
			-- your custom config here (optional)
		})
	end,
}
