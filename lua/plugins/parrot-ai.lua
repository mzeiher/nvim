return {
	"frankroeder/parrot.nvim",
	dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
	opts = {},
	config = function()
		require("parrot").setup({
			-- Providers must be explicitly added to make them available.
			providers = {
				pplx = {
					api_key = os.getenv("PERPLEXITY_API_KEY"),
				},
			},
		})

		vim.keymap.set("n", "<leader>pcn", ":PrtChatNew<cr>", { desc = "start new chat" })
		vim.keymap.set("n", "<leader>pct", ":PrtChatToggle<cr>", { desc = "toggle chat" })
	end,
}
