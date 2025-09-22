-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<Leader><Leader>", "<C-w><C-w>", { noremap = true, silent = true })

vim.keymap.set("i", "gq", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("v", "gq", "<Esc>", { noremap = true, silent = true })

-- leader+space to clear out search
vim.keymap.set("n", "<Leader><Space>", ":noh<CR>", { noremap = true, silent = true })

vim.keymap.set(
  "n",
  "<Leader>fS",
  "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
  { desc = "LSP workspace symbols" }
)
