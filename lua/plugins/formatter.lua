return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				terraform = { "terraform_fmt" },
				dart = { "dart_format" },
				python = { "ruff_organize_imports", "ruff" },
				json = { "jq" },
				yaml = { "yq" },
				-- xml = { "yq" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
		vim.keymap.set("n", "<leader>bf", function()
			require("conform").format({ async = true })
		end, { desc = "Format buffer" })
	end,
}
