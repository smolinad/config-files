return {
    "mfussenegger/nvim-dap",
    opts = {},
    config = function ()
        vim.keymap.set('n', "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
        vim.keymap.set('n', "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start or continue the debugger" })
    end
}
