-- Optional, hardware-specific override for Arduino development.
-- This file alone does nothing: arduino_language_server is not in
-- lsp_servers (lua/plugins/mason.lua), so vim.lsp.enable() is never called
-- for it and this config is never resolved. See
-- docs/customization.md#arduino-support-optional for how to turn it on.
-- Once enabled, this override only takes effect if arduino-cli and clangd
-- are actually on your $PATH; otherwise nvim-lspconfig's bundled default is
-- used untouched.
-- Customize the FQBN below (or the arduino-cli config path) for your board.
local arduino_cli = vim.fn.exepath("arduino-cli")
local clangd = vim.fn.exepath("clangd")

if arduino_cli == "" or clangd == "" then
	return {}
end

return {
	cmd = {
		"arduino-language-server",
		"-cli",
		arduino_cli,
		"-cli-config",
		vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
		"-fqbn",
		"arduino:avr:leonardo", -- change to match your board
		"-clangd",
		clangd,
	},
}
