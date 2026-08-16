local lint = require("lint")
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
	pattern = { "Makefile", "makefile", "*.mk" },
	callback = function()
		lint.try_lint()
	end,
})

