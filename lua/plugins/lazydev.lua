-- Faster, more accurate LuaLS setup for editing this Neovim config: it injects
-- the Neovim runtime and installed plugins' types into the LuaLS workspace
-- library on demand, so `vim.api.`, `vim.lsp.`, `vim.diagnostic.`, etc. and
-- `require("...")` for installed plugins resolve and complete correctly.
-- https://github.com/folke/lazydev.nvim

return {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			-- Bundled LuaLS addon with luv (vim.uv) type stubs.
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}
