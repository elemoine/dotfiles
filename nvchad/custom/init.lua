vim.g.mapleader = ","

vim.api.nvim_set_keymap("n", "<Leader><Leader>", "<C-w><C-w>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "gq", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "gq", "<Esc>", { noremap = true, silent = true })

-- leader+space to clear out search
vim.api.nvim_set_keymap("n", "<Leader><Space>", ":noh<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Leader>fS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "LSP workspace symbols"})

vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.opt.textwidth = 80
vim.opt.colorcolumn = "88"
