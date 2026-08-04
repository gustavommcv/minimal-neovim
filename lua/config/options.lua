local opt = vim.opt

opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.number = true
opt.relativenumber = true

-- Persistent undo, stored under Neovim's state directory (not inside the config repo).
opt.undofile = true
opt.undodir = vim.fs.joinpath(vim.fn.stdpath("state"), "undo")
vim.fn.mkdir(opt.undodir:get()[1], "p")
