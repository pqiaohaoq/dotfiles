return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = false,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
      sort_case_insensitive = true,
      default_component_configs = {
        container = { enable_character_fade = true },
        indent = { indent_size = 2, padding = 1 },
        icon = { enabled = false },
        name = { trailing_slash = false, use_git_status_colors = true },
        git_status = {
          symbols = {
            added = "+",
            modified = "*",
            deleted = "-",
            renamed = "→",
            untracked = "?",
            ignored = "!",
            staged = "s",
          }
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = false,
        window = {
          position = "left",
          mappings = {
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",
          },
        },
      },
    })
    vim.keymap.set("n", "<Leader>e", "<cmd>Neotree toggle<cr>")
  end,
}
