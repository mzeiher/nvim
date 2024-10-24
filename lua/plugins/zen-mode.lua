return {
	"folke/zen-mode.nvim",
	config = function()
		local zen_mode = require("zen-mode")
		zen_mode.setup({
			window = {
				width = 180, -- Breite in Pixeln
				options = {
					relativenumber = true, -- disable relative numbers
					cursorline = true, -- disable cursorline
					cursorcolumn = true, -- disable cursor column
				},
			},
			-- Weitere Zen-Mode-Optionen hier...
		})
	end,
	vim.api.nvim_set_keymap(
		"n",
		"<leader>z",
		"<cmd>ZenMode<CR>",
		{ desc = "[z]en mode", noremap = true, silent = true }
	),
}
