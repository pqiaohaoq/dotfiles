return {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup({
      use_diagnostic_signs = true,
    })
  end,
}
