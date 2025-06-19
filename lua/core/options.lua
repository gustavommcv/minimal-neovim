local opt = vim.opt

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.number = true
opt.relativenumber = true

opt.undofile = true
opt.undodir = vim.fn.stdpath("config") .. "/undodir//"
vim.fn.mkdir(vim.fn.stdpath("config") .. "/undodir", "p")

opt.cursorline = true

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
