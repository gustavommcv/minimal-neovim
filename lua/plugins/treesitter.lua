-- Nvim Treesitter configurations and abstraction layer.
-- Requires Neovim >= 0.12 and the tree-sitter CLI (plus a C compiler) to
-- compile parsers locally. This plugin cannot be lazy-loaded.
-- https://github.com/nvim-treesitter/nvim-treesitter

local parsers = {
	-- Neovim config development
	"lua",
	"vim",
	"vimdoc",
	"query",
	-- Docs
	"markdown",
	"markdown_inline",
	-- Web / TS stack
	"javascript",
	"typescript",
	"tsx",
	"html",
	"css",
	"json",
	"yaml",
	-- Other supported languages
	"bash",
	"python",
	"go",
	"c",
	"cpp",
	"latex",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		-- No-op for parsers that are already installed.
		ts.install(parsers)

		-- vim.treesitter.start() resolves the parser from the buffer's filetype
		-- itself (e.g. "sh" -> bash, "typescriptreact" -> tsx, "help" -> vimdoc),
		-- so filetypes are not enumerated here. pcall covers filetypes with no
		-- installed/available parser.
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				if pcall(vim.treesitter.start) then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
