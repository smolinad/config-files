return {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio"
    },
    config = function ()
        local dap = require("dap")
        local ui = require("dapui")

        ui.setup()
        dap.listeners.after.event_initialized['dapui_config'] = function ()
            ui.open()
        end
        dap.listeners.before.event_terminated['dapui_config'] = function ()
            ui.close()
        end
        dap.listeners.before.event_exited['dapui_config'] = function ()
            ui.close()
        end
    end,
}
