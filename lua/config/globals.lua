local	env = require("utils.env")

vim.g.user = env.get("FT_USER", "username")
vim.g.mail = env.get("FT_MAIL", "your@mail.com")
