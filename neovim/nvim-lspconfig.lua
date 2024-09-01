-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.clojure_lsp.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
}
lspconfig.tsserver.setup {}
--[[
lspconfig.lua_ls.setup {
  cmd = 'lua-lsp',
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
]]--
-- lspconfig.eslint.setup {}

vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist)
vim.keymap.set('n', '<Leader>dj', vim.diagnostic.goto_next)
vim.keymap.set('n', '<Leader>dk', vim.diagnostic.goto_prev)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<Leader>gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Leader>td', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<Leader>K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<Leader>fr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>F', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

