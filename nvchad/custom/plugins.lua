local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "mypy",
        "pyright",
        "ruff",
        "ruff-lsp",
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = "Git",
    dependencies = {
      "tpope/vim-rhubarb"
    }
  },
  {
    "tpope/vim-rhubarb"
  }
}
return plugins
