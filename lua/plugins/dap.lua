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
			vim.keymap.set("n", "<leader>dT", function()
				require("dap").terminate()
			end, { desc = "terminate" })
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
			dap.adapters.go = {
				type = "executable",
				command = "node",
				args = { os.getenv("HOME") .. "/.config/nvim/3rdparty/debugAdapter.js" },
			}
			dap.configurations.go = {
				{
					type = "go",
					name = "Debug",
					request = "launch",
					program = "${file}",
					dlvToolPath = vim.fn.exepath("dlv"),
					console = "integratedTerminal",
					terminal = "integratedTerminal",
				},
			}
			-- codelldb
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					-- CHANGE THIS to your path!
					command = "/home/mathis/opt/codelldb/adapter/codelldb",
					args = { "--port", "${port}" },
				},
			}
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
			dap.configurations.c = dap.configurations.cpp
			dap.configurations.rust = dap.configurations.cpp
			dap.configurations.zig = dap.configurations.cpp

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					-- 💀 Make sure to update this path to point to your installation
					args = { "/home/mathis/opt/js-debug/src/dapDebugServer.js", "${port}" },
				},
			}
			dap.configurations.javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}
			dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
		end,
	},
}
