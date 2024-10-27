return {
	"mhartington/formatter.nvim",
	opts = function()
		return {
			filetype = {
				go = {
					require("formatter.filetypes.go").gofmt,
					require("formatter.filetypes.go").goimports,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
			},
		}
	end,
	config = function(_, opts)
		require("formatter").setup(opts)

		-- Create an augroup for formatter
		vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })

		-- Set up autocommand to run formatter on save for Go files
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*.go",
			group = "FormatAutogroup",
			callback = function()
				vim.cmd("FormatWrite")
			end,
		})
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*.lua",
			group = "FormatAutogroup",
			callback = function()
				vim.cmd("FormatWrite")
			end,
		})

		vim.api.nvim_set_keymap("n", "<leader><space>f", ":Format<cr>", { silent = true, noremap = true })
	end,
}
