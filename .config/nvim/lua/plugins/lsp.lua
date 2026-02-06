return {
  "neovim/nvim-lspconfig",
  config = function()
    local on_attach = function(client, bufnr)
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ timeout_ms = 2000 })
          end,
        })
      end
    end

    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
    })

    vim.lsp.config("clangd", {})

    vim.lsp.config("bashls", {})

    vim.lsp.enable("gopls")
    vim.lsp.enable("clangd")
    vim.lsp.enable("bashls")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        on_attach(client, ev.buf)
      end,
    })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end,
    })
  end,
}
