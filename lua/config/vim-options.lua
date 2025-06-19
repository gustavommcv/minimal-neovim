vim.g.mapleader = " "

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("config") .. "/undodir//"
vim.fn.mkdir(vim.fn.stdpath("config") .. "/undodir", "p")

vim.opt.relativenumber = true
