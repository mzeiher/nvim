return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
			})
		end,
	},
	{
		"nvim-lua/lsp-status.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.gitlab_ci_ls.setup({
				capabilities = capabilities,
			})
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.gitlab-ci*.{yml,yaml}",
				callback = function()
					vim.bo.filetype = "yaml.gitlab"
				end,
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})

			lspconfig.zls.setup({
				capabilities = capabilities,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
			})

			lspconfig.dartls.setup({
				capabilities = capabilities,
			})

			lspconfig.taplo.setup({
				capabilities = capabilities,
			})

			lspconfig.sourcekit.setup({
				capabilities = capabilities,
				filetypes = { "swift", "objc", "objcpp", "swiftinterface" },
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local telescope_builtin = require("telescope.builtin")
					vim.keymap.set(
						"n",
						"gy",
						telescope_builtin.lsp_type_definitions,
						{ buffer = ev.buf, desc = "type definitions" }
					)
					vim.keymap.set(
						"n",
						"gd",
						telescope_builtin.lsp_definitions,
						{ buffer = ev.buf, desc = "type definitions" }
					)
					vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = ev.buf, desc = "lsp hover" })
					vim.keymap.set("n", "gE", vim.diagnostic.open_float, { buffer = ev.buf, desc = "diagnostics" })
					vim.keymap.set(
						"n",
						"gI",
						telescope_builtin.lsp_implementations,
						{ buffer = ev.buf, desc = "implementations" }
					)
					vim.keymap.set(
						"n",
						"ds",
						telescope_builtin.lsp_document_symbols,
						{ buffer = ev.buf, desc = "document symbols" }
					)
					vim.keymap.set(
						"n",
						"dS",
						telescope_builtin.lsp_workspace_symbols,
						{ buffer = ev.buf, desc = "workspace symbols" }
					)
					vim.keymap.set(
						"n",
						"cr",
						vim.lsp.buf.rename,
						{ buffer = ev.buf, desc = "rename symbol (refactor)" }
					)
					-- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					-- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
					-- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
					-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					-- enable inlay hints
					vim.keymap.set("n", "<leader>bh", function()
						local bufnr = vim.api.nvim_get_current_buf()
						vim.lsp.inlay_hint.enable(
							not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
							{ bufnr = bufnr }
						)
					end, { noremap = true, silent = true, desc = "enable inlay hint for buffer" })
					vim.keymap.set("n", "<leader>H", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
					end, { noremap = true, silent = true, desc = "enable inlay hints globally" })
				end,
			})
		end,
	},
}
