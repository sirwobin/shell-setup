vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
