require("nvim-tree").setup({
  sort_by = "case_insensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        -- :help nvim-tree-mappings
        { key = "u", action = "dir_up" },
        { key = "C", action = "cd" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
