local keymap = vim.keymap.set

-- Editor
keymap("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap("v", "<leader>p", '"+p', { desc = "Paste to system clipboard" })

-- LSP
keymap("n", "K", vim.lsp.buf.hover, {})
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See code actions" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename variables" })
keymap("n", "<leader>gf", vim.lsp.buf.format, { desc = "[G]o [F]ormat (LSP)" })

-- Neotree
keymap("n", "<leader>e", "<Cmd>Neotree toggle<CR>")

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Telescope find git files" })
