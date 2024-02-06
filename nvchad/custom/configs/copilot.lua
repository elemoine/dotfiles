vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-c>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.keymap.set('i', '<C-w>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-line)')
