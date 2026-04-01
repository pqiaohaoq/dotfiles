return {
  "neovim/nvim-lspconfig",
  config = function()
    -- gopls 配置
    vim.lsp.config("gopls", {
      settings = {
        gopls = {
          analyses = {
            unusedparams = true, -- 检测未使用的参数
          },
          staticcheck = true, -- 启用 staticcheck 静态分析
          gofumpt = true, -- 使用 gofumpt 格式化
        },
      },
    })

    vim.lsp.enable("gopls")
    vim.lsp.enable("pyright")

    -- ruff 作为 Python 格式化 + lint 工具
    vim.lsp.config("ruff", {
      init_options = {
        settings = {
          organizeImports = true,
        },
      },
    })
    vim.lsp.enable("ruff")

    -- Python 文件保存时自动格式化
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function(args)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = args.buf,
          callback = function()
            vim.lsp.buf.format({ bufnr = args.buf })
          end,
        })
      end,
    })

    -- 光标停留时自动显示诊断浮窗
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.diagnostic.open_float(nil, { focus = false })
      end,
    })
  end,
}
