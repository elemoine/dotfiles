return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Find or create the section where you want the LSP name to appear (e.g., lualine_x or lualine_y)
    opts.sections.lualine_x = {
      -- ... your other components like diagnostics or filetype ...
      -- Add this custom component for the LSP names:
      {
        function()
          local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
          if next(buf_clients) == nil then
            return "No LSP"
          end
          local client_names = {}
          for _, client in pairs(buf_clients) do
            table.insert(client_names, client.name)
          end
          return "LSP: " .. table.concat(client_names, ", ")
        end,
        color = { fg = "#ffffff", gui = "bold" }, -- Feel free to change the color
      },
    }
  end,
}
