local	categories = require("config.categories")

return {
  "WeiTing1991/suannhai.nvim",
  enabled = categories.is_enabled("themes"),
  lazy = false,
  priority = 1000,
  build = "python3 scripts/sync-palettes.py",
}
