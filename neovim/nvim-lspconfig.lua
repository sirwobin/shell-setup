

local on_attach_fn = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<Leader>K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('v', '<Leader>ca', vim.lsp.buf.range_code_action, bufopts)
  vim.keymap.set('n', '<Leader>fr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, bufopts)
  vim.keymap.set('n', '<Leader>dj', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<Leader>dk', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', '<Leader>F', function() vim.lsp.buf.format { async = true } end, bufopts)
end


require'lspconfig'.clojure_lsp.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  on_attach = on_attach_fn,
}
