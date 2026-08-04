-- Highly customizable theme with support for LSP, Treesitter and a variety of plugins.
-- https://github.com/EdenEast/nightfox.nvim

return {
	"EdenEast/nightfox.nvim",
	lazy = false, -- colorscheme must be available immediately at startup
	priority = 1000, -- load before other plugins that may rely on highlight groups
	config = function()
		vim.cmd.colorscheme("carbonfox")
	end,
}
