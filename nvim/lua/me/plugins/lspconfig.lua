return {
  "neovim/nvim-lspconfig",
  event = { "bufreadpre", "bufnewfile" },
  dependencies = {
    -- add lsp completion capabilities
    "hrsh7th/cmp-nvim-lsp",

    -- add completion for the nvim lua api
    "folke/neodev.nvim"
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      -- avoid tsserver clash with denols
      if lspconfig.util.root_pattern("deno.json", "import_map.json")(vim.fn.getcwd()) then
        if client.name == "tsserver" then
          client.stop()
          return
        end
      end

      keymap.set("n", "gd", "<cmd>telescope lsp_definitions<cr>", { buffer = bufnr, desc = "goto definition"})
      keymap.set("n", "gr", "<cmd>telescope lsp_references<cr>", { buffer = bufnr, desc = "goto references"})
      keymap.set("n", "gi", "<cmd>telescope lsp_implementations<cr>", { buffer = bufnr, desc = "goto implementation"})
      keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "show documentation"})
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "smart rename"})
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "code actions"})

      vim.api.nvim_buf_create_user_command(bufnr, 'format', function(_)
        vim.lsp.buf.format()
      end, { desc = "format current buffer with lsp"})
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    -- change the diagnostic symbols in the sign column (gutter)
    -- local signs = { Error = " ", Warn = " ", Hint = "* ", Info = " " }
    -- for type, icon in pairs(signs) do
    --  local hl = "DiagnosticSign" .. type
    --  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    -- end

    local servers = {
      "cssls",
      "gopls",
      "rust_analyzer",
    }

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end

    lspconfig["denols"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc", "import_map.json")
    })

    lspconfig["tsserver"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json")
    })

    -- lua_ls
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    -- setup neovim lua documentation
    require("neodev").setup()
  end,
}
