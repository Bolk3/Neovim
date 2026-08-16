local	categories = require("config.categories")

local servers = { "lua_ls", "clangd", "pylsp" }

return {
	"mason-org/mason-lspconfig.nvim",
	enable = categories.is_enabled("LSP"),
	config = function ()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = servers,
		})

		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		vim.lsp.enable(servers)
	end
}
