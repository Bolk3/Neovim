local	colorcloumn = {
	python      = "80,100",
	lua         = "80,120",
	javascript  = "80,100",
	typescript  = "80,100",
	go          = "100,120",
	rust        = "100",
	c           = "80",
	cpp         = "80,120",
	java        = "100,120",
	ruby        = "80,120",
	php         = "80,120",
	html        = "100",
	css         = "80",
	scss        = "80",
	markdown    = "80",
	yaml        = "80",
	json        = "100",
	sh          = "80",
	bash        = "80",
	gitcommit   = "50,72",
	sql         = "80,100",
	vim         = "80",
	dockerfile  = "80",
	toml        = "80",
	haskell     = "80,100",
	swift       = "100,120",
	kotlin      = "100,120",
	csharp      = "100,120",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function ()
		local	ft = vim.bo.filetype
		vim.opt_local.colorcolumn = colorcloumn[ft]
	end,
})
