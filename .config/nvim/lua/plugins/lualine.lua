return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "nord",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "neo-tree" },
        globalstatus = false,
      },
      sections = {
        lualine_a = { { "branch", icon = "" } },
        lualine_b = { { "filename", path = 1, icon = "" } },
        lualine_c = {},
        lualine_x = { { "encoding", icon = "" } },
        lualine_y = { { function() return string.format("%d:%d/%d", vim.fn.line("."), vim.fn.col("."), vim.fn.line("$")) end, icon = "" } },
        lualine_z = { { "diagnostics", icons_enabled = false } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { { "filename", path = 1, icon = "" } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { { function() return string.format("%d:%d/%d", vim.fn.line("."), vim.fn.col("."), vim.fn.line("$")) end, icon = "" } },
        lualine_z = {},
      },
    })
  end,
}
