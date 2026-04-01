return {
  "saghen/blink.cmp",
  version = "1.*",
  opts = {
    keymap = {
      preset = "default",
      ["<Tab>"] = { "select_next", "fallback" },     -- Tab 选择下一个补全项，无菜单时插入缩进
      ["<S-Tab>"] = { "select_prev", "fallback" },   -- Shift+Tab 选择上一个补全项
      ["<CR>"] = { "accept", "fallback" },            -- Enter 确认补全，无菜单时换行
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "normal",
    },
    sources = {
      default = { "lsp", "path", "buffer" },
    },
    completion = {
      documentation = {
        auto_show = true, -- 选中补全项时自动显示文档
      },
    },
  },
}
