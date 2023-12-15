return {
  "catppuccin/nvim",
  priority = 1000,
  name = "catppuccin",
  config = function()
    local catppuccin = require("catppuccin")

    catppuccin.setup({
      flavour = "mocha",
      integrations = {
        cmp = true,
        nvimtree = true
      }
    })

    -- load the colorscheme
    vim.o.termguicolors = true
    vim.cmd.colorscheme("catppuccin")
  end,
}
