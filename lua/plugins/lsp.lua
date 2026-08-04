-- Quickstart configs for Nvim LSP.
-- Servers are installed by mason.lua and enabled there via mason-lspconfig's
-- automatic_enable; this file only supplies what nvim-lspconfig itself is
-- for: the bundled `lsp/<server>.lua` definitions (cmd, filetypes, root
-- markers) consumed by `vim.lsp.config`/`vim.lsp.enable`. There is no
-- `require("lspconfig").<server>.setup()` call anywhere in this config.
-- https://github.com/neovim/nvim-lspconfig
-- Per-server customization lives in after/lsp/<server>.lua.

return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Advertise blink.cmp's completion capabilities to every server.
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		-- LSP-dependent keymaps only apply to buffers with a client attached.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(args)
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
				end

				map("n", "K", vim.lsp.buf.hover, "Hover documentation")
				map("n", "gd", vim.lsp.buf.definition, "Go to definition")
				map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				map("n", "gr", vim.lsp.buf.references, "Go to references")
				map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
			end,
		})
	end,
}
