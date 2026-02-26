return {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    local servers = { "gopls", "clangd", "bashls", "pyright", "ts_ls", "ruff" }
    local mlspconfig = require("mason-lspconfig")
    mlspconfig.setup({
      ensure_installed = servers,
      handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end,
      },
    })

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      mlspconfig.setup({ ensure_installed = servers })
    end, { desc = "Install all Mason LSP servers" })
  end,
}
