vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged" }, {
  pattern = {"*.clj", "*.cljs", "*.cljc", "*.edn"},
  callback = function()
    require("lint").try_lint()
  end,
})
