return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VimEnter",
		config = function()
			require("telescope").setup({
				extensions = {
					file_browser = {},
				},
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--ignore-file",
						".gitignore",
					},
				},
			})

			require("telescope").load_extension("file_browser")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			vim.keymap.set(
				"n",
				"<leader>fd",
				"<cmd>Telescope diagnostics bufnr=0<CR>",
				{ desc = "Telescope show diagnostics" }
			)
			vim.keymap.set("n", "<leader>fD", "<cmd>Telescope diagnostics<CR>", { desc = "Telescope show diagnostics" })
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			vim.keymap.set("n", "<leader>fB", ":Telescope file_browser<CR>")

			-- open file_browser with the path of the current buffer
			-- vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
		end,
	},
}
