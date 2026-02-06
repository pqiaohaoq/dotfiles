return {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "gopls", "clangd", "bashls" },
      handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end,
      },
    })
  end,
}
