return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- UI for debugging
		"rcarriga/nvim-dap-ui",
		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",
		-- Optional: installs debuggers automatically if you use mason
		"williamboman/mason.nvim",
	},
	config = function()
		local dap = require("dap")
		-- Python
		dap.adapters.python = {
			type = "executable",
			command = "/usr/bin/python3",
			args = { "-m", "debugpy.adapter" },
		}
		-- C
		dap.adapters.cppdbg = {
			command = "/usr/bin/gdb",
			type = "executable",
			args = { "--interpreter=dap" },
			options = { log_level = "debug" },
		}

		dap.adapters.armgdb = {
			command = "/usr/bin/arm-none-eabi-gdb",
			type = "executable",
			args = { "--interpreter=dap" },
			options = { log_level = "debug" },
		}
		dap.configurations = {
			python = {
				{
					type = "python", -- Must match the adapter name above
					request = "launch",
					name = "Launch file",
					program = "${file}", -- Runs the current file
					pythonPath = function()
						return "${workspaceFolder}/.venv/bin/python3"
					end,
				},
			},
			c = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", ".venv/bin/python3")
					end,
					args = function()
						local args_string = vim.fn.input("Arguments: ")
						return vim.split(args_string, " +")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = false,
					MIMode = "gdb",
				},
				{
					name = "Attach to Arm target :3333",
					type = "armgdb",
					request = "attach",
					target = ":3333",
					stopAtEntry = true,
					-- MIDebuggerPath = '/usr/bin/arm-none-eabi-gdb',
					-- MIMode = 'gdb',
					cwd = "${workspaceFolder}",
					program = function()
						return vim.fn.input("Path to executable: ", "FOO.elf")
					end,
				},
			},
			cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", ".venv/bin/python3")
					end,
					args = function()
						local args_string = vim.fn.input("Arguments: ", "BAR")
						return vim.split(args_string, " +")
					end,
					cwd = "${workspaceFolder}",
					stopAtEntry = false,
					MIMode = "gdb",
				},
			},
		}
		local dapui = require("dapui")

		-- 1. Setup DAP UI
		dapui.setup()

		-- Automatically open/close the DAP UI when debugging starts/stops
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
	end,
}
