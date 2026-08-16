local	categories = require("config.categories")

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  enabled = categories.is_enabled("LSP"),
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "checkmake",
      },
      auto_update = true,   -- passe à true si tu veux qu'il se mette à jour automatiquement
      run_on_start = true,   -- installe au démarrage de Neovim
    })
  end,
}
