-- Alpha dashboard customized for "Minimal Neovim"
-- Fast, clean, distraction-free
-- https://github.com/goolord/alpha-nvim

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Header: Minimal Neovim
		dashboard.section.header.val = {
			"",
			"      ███╗   ███╗ ██╗ ███╗   ██╗ ██╗ ███╗   ███╗  █████╗ ██╗      ",
			"      ████╗ ████║ ██║ ████╗  ██║ ██║ ████╗ ████║ ██╔══██╗██║      ",
			"      ██╔████╔██║ ██║ ██╔██╗ ██║ ██║ ██╔████╔██║ ███████║██║      ",
			"      ██║╚██╔╝██║ ██║ ██║╚██╗██║ ██║ ██║╚██╔╝██║ ██╔══██║██║      ",
			"      ██║ ╚═╝ ██║ ██║ ██║ ╚████║ ██║ ██║ ╚═╝ ██║ ██║  ██║███████╗",
			"      ╚═╝     ╚═╝ ╚═╝ ╚═╝  ╚═══╝ ╚═╝ ╚═╝     ╚═╝ ╚═╝  ╚═╝╚══════╝",
			"",
			"                        Minimal Neovim",
			"                 fast • clean • distraction-free",
			"",
		}

		-- Buttons
		dashboard.section.buttons.val = {
			dashboard.button("n", "   New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "󰮗   Find file", ":cd $HOME | Telescope find_files<CR>"),
			dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("g", "󱘞   Ripgrep", ":Telescope live_grep<CR>"),
			dashboard.button("c", "   Config", ":cd ~/.config/nvim | e init.lua<CR>"),
			dashboard.button("q", "󰗼   Quit", ":qa<CR>"),
		}

		-- Footer
		local function footer()
			local datetime = os.date("%A, %d %B %Y  •  %H:%M")
			return "" .. datetime .. ""
		end

		dashboard.section.footer.val = footer()

		-- Layout spacing
		dashboard.config.layout = {
			{ type = "padding", val = 2 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 1 },
			dashboard.section.footer,
		}

		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
