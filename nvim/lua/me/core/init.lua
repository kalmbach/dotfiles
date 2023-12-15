-- set leader key to space (Spacebar)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

-- KEYMAPS --
-- Window movement
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")

-- clear search hightlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search hightlights" })

-- Show next search result in the center of screen
keymap.set("n", "n", "nzz", { desc = "Show next search result" })
keymap.set("n", "N", "Nzz", { desc = "Show previous search result" })

-- Buffer movement
keymap.set("n", "<tab>", ":bn<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<S-tab>", ":bp<CR>", { desc = "Go to previous buffer" })

-- Diagnostic keymaps
vim.keymap.set('n', ',d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', '.d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Deactivate recording
-- keymap.set("", "q", "<nop>", { desc = "Deactivate recording" })
vim.filetype.add({
  extension = {
    coffee = 'coffeescript'
  }
})

-- OPTIONS --

-- Reload files changed outside vim
vim.o.autoread = true

-- Automatically :write before running commands
vim.o.autowrite = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Sync clipboard between OS and Neovim.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Number of spaces that a <Tab> counts for
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Show matches when searching
vim.o.incsearch = true

-- Set highlight on search
vim.o.hlsearch = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal support this
vim.o.termguicolors = true

-- Open new horizontal split at bottom 
-- Open new vertical split at right
vim.o.splitbelow = true
vim.o.splitright = true
-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

