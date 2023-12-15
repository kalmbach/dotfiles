return {
  -- lua functions that many plugins use
  "nvim-lua/plenary.nvim",

  -- tmux & split window navigation
  "christoomey/vim-tmux-navigator",

  "nvim-tree/nvim-web-devicons",
  "tpope/vim-fugitive",

  -- Autopairs {} () []
  { "windwp/nvim-autopairs", opts = {} },

  -- Add/Delete/Change surrounding pairs
  { "kylechui/nvim-surround", version = "*", config = true },

  -- Useful plugin to show you pending keybinds
  { "folke/which-key.nvim", opts = {} },

  -- "gc" to comment visual region/lines
  { "numToStr/Comment.nvim", opts = {}, config = true },

  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>" }
    }
  },
}
