vim.g.mapleader = " "
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"

require("config.lazy")

require("core.options")
require("core.keymaps")
require("core.theme")
