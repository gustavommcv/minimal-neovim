-- A high-performance color highlighter for Neovim which has no external dependencies! Written in performant Luajit.
-- https://github.com/norcalli/nvim-colorizer.lua

return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		require("colorizer").setup()
	end,
}
