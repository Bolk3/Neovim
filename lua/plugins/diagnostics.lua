local	categories = require("config.categories")

return {
    "rachartier/tiny-inline-diagnostic.nvim",
    enabled = categories.is_enabled("LSP"),
    event = "VeryLazy",
    priority = 1000,
    config = function()
        require("tiny-inline-diagnostic").setup()
        vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    end,
}
