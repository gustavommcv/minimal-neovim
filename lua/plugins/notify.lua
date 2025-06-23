-- A fancy, configurable, notification manager for NeoVim
-- https://github.com/rcarriga/nvim-notify
return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			render = "simple",
			top_down = false,
		})

		vim.notify = require("notify")
	end,
}
