local categories = require("config.categories")

return {
	"mason-org/mason.nvim",
	enabled = categories.is_enabled("LSP"),
	opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
}
