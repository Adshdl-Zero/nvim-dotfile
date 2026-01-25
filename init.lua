-- Neovim version check
if vim.fn.has("nvim-0.11") == 0 then
	vim.notify("This configuration requires Neovim >= 0.11", vim.log.levels.ERROR)
	return
end

require("pino")
