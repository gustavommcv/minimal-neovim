local keymap = vim.keymap.set

-- Clipboard
keymap("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
keymap("v", "<leader>p", '"+p', { desc = "Paste to system clipboard" })
keymap("n", "<leader>Y", ":%y+<CR>", { desc = "Copy entire buffer to system clipboard" })

-- Diagnostics (works even without an LSP client attached, e.g. diagnostics from nvim-lint)
keymap("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })
keymap("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })

-- LSP and Telescope/Neo-tree keymaps live next to their plugin specs
-- (lua/plugins/lsp.lua, telescope.lua, neotree.lua) so they only apply where relevant.
