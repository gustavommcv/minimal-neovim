local keymap = vim.keymap.set

keymap("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap("v", "<leader>p", '"+p', { desc = "Paste to system clipboard" })
