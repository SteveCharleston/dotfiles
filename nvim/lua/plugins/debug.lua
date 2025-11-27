return {
    {
        "mfussenegger/nvim-dap",
        ---@module 'dap'
        ---@type dap.Config
        config = function()
            local dap = require("dap")
            dap.adapters.python = {
                type = 'executable',
                --command = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python',
                command = "python3",
                args = { '-m', 'debugpy.adapter' },
            }
            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = "Launch file",
                    program = "${file}",
                    args = function()
                        -- 1. Prompt the user for a single string of arguments
                        local input_args = vim.fn.input('Enter command line arguments: ')

                        -- If the user cancels the prompt (input_args is nil or empty), 
                        -- return an empty table to safely launch with no arguments.
                        if not input_args or input_args == "" then
                            return {}
                        end

                        -- 2. Split the single string by spaces into a table (array) of strings
                        -- This matches the `args` requirement of the debug adapter.
                        return vim.split(input_args, ' ', { trimempty = true })
                    end,
                    pythonPath = function()
                        return vim.fn.exepath("python3")
                    end,
                },
                {
                    name= "Pytest: Current File",
                    type= "python",
                    request= "launch",
                    module= "pytest",
                    justMyCode= false,
                    args= {
                        "${file}",
                        "-sv",
                        "--log-cli-level=INFO",
                        "--log-file=test_out.log"
                    },
                    console= "integratedTerminal",
                }
            }
        end,
        keys = {
            {
                "<Home>",
                function() require("dap").continue() end,
                desc = "DAP: Continue",
            },
            {
                "<PageUp>",
                function() require("dap").step_over() end,
                desc = "DAP: Step Over",
            },
            {
                "<PageDown>",
                function() require("dap").step_into() end,
                desc = "DAP: Step Into",
            },
            {
                "<End>",
                function() require("dap").step_out() end,
                desc = "DAP: Step Out",
            },
            {
                "<Insert>",
                function() require("dap").toggle_breakpoint() end,
                desc = "DAP: Toggle Breakpoint",
            },
            {
                "<leader>B",
                function()
                    require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
                end,
                desc = "DAP: Set Breakpoint Condition",
            },
            {
                "<Del>",
                function()
                    require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
                end,
                desc = "DAP: Set Log Point",
            },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        lazy = false,
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        opts = {},
    },
    {
        "igorlfs/nvim-dap-view",
        opts = {
            winbar = {
                controls = {
                    enabled = true,
                },
            }
        },
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
    {
        "LiadOz/nvim-dap-repl-highlights",
        config = function()
            require("nvim-dap-repl-highlights").setup()
        end,
    }
}
