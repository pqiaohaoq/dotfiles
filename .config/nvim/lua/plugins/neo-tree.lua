return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  opts = {
    default_component_configs = {
      icon = {
        folder_closed = ">",
        folder_open = "v",
        folder_empty = "-",
        default = " ",
        provider = function(icon, node)
          if node.type == "directory" then
            return
          end
          icon.text = " "
        end,
      },
      git_status = {
        symbols = {
          added = "+",
          modified = "~",
          deleted = "-",
          renamed = "r",
          untracked = "",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "!",
        },
      },
    },
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    source_selector = {
      winbar = true,
      sources = {
        { source = "filesystem", display_name = " File " },
        { source = "buffers", display_name = " Buff " },
        { source = "git_status", display_name = " Git " },
        { source = "document_symbols", display_name = " Sym " },
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    document_symbols = {
      renderers = {
        ["symbol"] = {
          { "indent" },
          { "name" },
          { "kind_name" },
        },
      },
      kinds = {
        File = { icon = "F" },
        Module = { icon = "M" },
        Namespace = { icon = "N" },
        Package = { icon = "P" },
        Class = { icon = "C" },
        Method = { icon = "m" },
        Property = { icon = "p" },
        Field = { icon = "f" },
        Constructor = { icon = "c" },
        Enum = { icon = "E" },
        Interface = { icon = "I" },
        Function = { icon = "F" },
        Variable = { icon = "v" },
        Constant = { icon = "K" },
        String = { icon = "s" },
        Number = { icon = "n" },
        Boolean = { icon = "b" },
        Array = { icon = "a" },
        Object = { icon = "o" },
        Key = { icon = "k" },
        Null = { icon = "0" },
        EnumMember = { icon = "e" },
        Struct = { icon = "S" },
        Event = { icon = "E" },
        Operator = { icon = "+" },
        TypeParameter = { icon = "T" },
      },
    },
    window = {
      width = 30,
      mappings = {
        ["<C-r>"] = "none",
      },
    },
  },
}
