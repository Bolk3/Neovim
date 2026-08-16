local	categories = require("config.categories")

return {
    "lewis6991/gitsigns.nvim",
    enabled = categories.is_enabled("git"),
}
