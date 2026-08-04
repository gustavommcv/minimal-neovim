-- VimTeX: A modern Vim and neovim filetype plugin for LaTeX files.
-- https://github.com/lervag/vimtex

return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- PDF viewer: zathura (Linux/BSD only). Windows/macOS users should set an
		-- alternative such as "general" with SumatraPDF or Skim (see docs/customization.md).
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
	end,
}
