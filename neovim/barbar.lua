
require'barbar'.setup {
  auto_hide = false,
  animation = true,
  tabpages = true,
  closable = true,
  clickable = true,
  maximum_padding = 4,
  maximum_length = 30,
  insert_at_start = false,
  insert_at_end = true,
  semantic_letters = true,
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  icons = {filetype = {enabled = true},
           pinned = {button = 'ᛍ'},
  }
}

-- Move to previous/next
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', {remap = false, silent = true})
-- Re-order to previous/next
vim.keymap.set('n', '<A-S-,>', '<Cmd>BufferMovePrevious<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-S-.>', '<Cmd>BufferMoveNext<CR>', {remap = false, silent = true})
-- Goto buffer in position...
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', {remap = false, silent = true})
vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', {remap = false, silent = true})

vim.api.nvim_set_hl(0, 'BufferCurrent', {fg=white})
vim.api.nvim_set_hl(0, 'BufferCurrentMod', {fg='#ff0000'})
vim.api.nvim_set_hl(0, 'BufferInactiveMod', {fg='#af0000'})
vim.api.nvim_set_hl(0, 'BufferVisibleMod', {fg='#e57474', bg='#3b4244'})

