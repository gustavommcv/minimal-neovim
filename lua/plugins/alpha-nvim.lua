-- alpha is a fast and fully programmable greeter for neovim.
-- https://github.com/goolord/alpha-nvim

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "RchrdAriza/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			"       ███╗░░██╗██╗░░░██╗██╗███╗░░░███╗",
			"       ████╗░██║██║░░░██║██║████╗░████║",
			"       ██╔██╗██║╚██╗░██╔╝██║██╔████╔██║",
			"       ██║╚████║░╚████╔╝░██║██║╚██╔╝██║",
			"       ██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║",
			"       ╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
			"",
			"                 █▀█ █▄░█  █▀▄▀█ █▄█            ",
			"                 █▄█ █░▀█  █░▀░█ ░█░            ",
			"",
			"       ░██╗░░░░░░░██╗░█████╗░██╗░░░██╗",
			"       ░██║░░██╗░░██║██╔══██╗╚██╗░██╔╝",
			"       ░╚██╗████╗██╔╝███████║░╚████╔╝░",
			"       ░░████╔═████║░██╔══██║░░╚██╔╝░░",
			"       ░░╚██╔╝░╚██╔╝░██║░░██║░░░██║░░░",
			"       ░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝░░░╚═╝░░░",
		}

		dashboard.section.buttons.val = {
			dashboard.button("n", "   New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "󰮗   Find file", ":cd $HOME | Telescope find_files<CR>"),
			dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("R", "󱘞   Ripgrep", ":Telescope live_grep<CR>"),
			dashboard.button("q", "󰗼   Quit", ":qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
