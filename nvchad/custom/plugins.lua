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
    cmd = {"Git", "GBrowse"},
    dependencies = {
      "tpope/vim-rhubarb"
    }
  },
  {
    "tpope/vim-rhubarb"
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "jlanzarotta/bufexplorer",
    lazy = false,
  }
}
return plugins
