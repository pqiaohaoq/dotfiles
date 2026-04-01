return {
  "shaunsingh/nord.nvim",
  lazy = false, -- 启动时立即加载
  priority = 1000, -- 确保在其他插件之前加载
  config = function()
    require("nord").set()
  end,
}
