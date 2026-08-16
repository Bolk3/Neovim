local	categories = require("config.categories")

return {
	"mason-org/mason-lspconfig.nvim",
	enable = categories.is_enabled("LSP"),
	opts = {
		ensure_installed = { "lua_ls", "clangd", "pylsp" },
	},
}
