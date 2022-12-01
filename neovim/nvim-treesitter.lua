require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  -- do a :TSInstall for the language as well
  ensure_installed = { "clojure", "lua" },
  highlight = { enable = true },
  rainbow = {
    enable = true,
    colors = { 'steelblue1','red','seagreen2','yellow','magenta1','darkslategray1','darkorange' },
  },
  indent = { enable = true }
}
