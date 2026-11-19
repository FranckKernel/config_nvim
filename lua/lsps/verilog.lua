-- lua/lsps/verilog.lua
local M = {}

M.config = {
    cmd = { "svls" }, -- SystemVerilog Language Server
    filetypes = { "verilog", "systemverilog", "v" }, -- Apply to Verilog files
    root_dir = require("lspconfig.util").root_pattern(".git", ".svls.json", ".sv"), -- Detect project root
    settings = {
        -- svls specific settings can go here if needed
    },

    on_attach = function(client, bufnr)
        -- your on_attach logic
        local lsp_helper = require("lsps.helper.lsp_config_helper")
        print("verilog lsp attached")
        lsp_helper.add_keybinds()
    end,
}

return M
