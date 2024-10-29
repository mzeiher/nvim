return {
	{ "nvim-telescope/telescope-dap.nvim" },
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- require("telescope").load_extension("dap")
			local dap = require("dap")

			-- general
			dap.defaults.fallback.focus_terminal = true

			-- keymap
			vim.keymap.set("n", "<leader>dc", function()
				require("dap").continue()
			end, { desc = "continue" })
			vim.keymap.set("n", "<leader>dss", function()
				require("dap").step_over()
			end, { desc = "step over" })
			vim.keymap.set("n", "<leader>dsi", function()
				require("dap").step_into()
			end, { desc = "step into" })
			vim.keymap.set("n", "<leader>dso", function()
				require("dap").step_out()
			end, { desc = "step out" })
			vim.keymap.set("n", "<Leader>db", function()
				require("dap").toggle_breakpoint()
			end, { desc = "toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dB", function()
				require("dap").set_breakpoint()
			end, { desc = "set breakpoint" })
			vim.keymap.set("n", "<Leader>dl", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "set log point" })
			vim.keymap.set("n", "<Leader>dr", function()
				require("dap").repl.open()
			end, { desc = "repl" })
			-- vim.keymap.set("n", "<Leader>dl", function()
			-- 	require("dap").run_last()
			-- end)
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "hover" })
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				require("dap.ui.widgets").preview()
			end, { desc = "preview" })
			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end, { desc = "stack frames" })
			vim.keymap.set("n", "<Leader>dv", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, { desc = "variables" })
			vim.keymap.set("n", "<Leader>dt", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.threads)
			end, { desc = "threads" })

			-- golang
			dap.adapters.delve = function(callback, config)
				if config.mode == "remote" and config.request == "attach" then
					callback({
						type = "server",
						host = config.host or "127.0.0.1",
						port = config.port or "38697",
					})
				else
					callback({
						type = "server",
						port = "${port}",
						executable = {
							command = "dlv",
							args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
							detached = vim.fn.has("win32") == 0,
						},
					})
				end
			end
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				-- works with go.mod packages and sub packages
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}
		end,
	},
}
