return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "[x]",
          package_pending = "[>]",
          package_uninstalled = "[ ]",
        },
      },
    })

    -- 自动安装
    local ensure_installed = { "gopls", "goimports", "pyright", "ruff", "bash-language-server" }
    local mr = require("mason-registry")
    local function install_packages()
      for _, pkg in ipairs(ensure_installed) do
        if not mr.is_installed(pkg) then
          mr.get_package(pkg):install()
        end
      end
    end
    if mr.refresh then
      mr.refresh(install_packages)
    else
      install_packages()
    end
  end,
}
