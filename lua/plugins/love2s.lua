-- using lazy.nvim
return {
	"S1M0N38/love2d.nvim",
	event = "VeryLazy",
	version = "2.*",
	config = function()
		require("love2d").setup({})
	end,
}
