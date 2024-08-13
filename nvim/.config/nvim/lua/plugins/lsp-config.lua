return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()

      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")


      lspconfig.lua_ls.setup({})
      lspconfig.ast_grep.setup({})

       -- Dart LSP setup
      lspconfig.dartls.setup({
        cmd = { "dart", "language-server", "--protocol=lsp" },
        filetypes = { "dart" },
        root_dir = lspconfig.util.root_pattern("pubspec.yaml", ".git"),
        init_options = {
          closingLabels = true,
          flutterOutline = true,
          onlyAnalyzeProjectsWithOpenFiles = true,
          outline = true,
          suggestFromUnimportedLibraries = true
        },
        settings = {
          dart = {
            completeFunctionCalls = true,
            showTodos = true,
          }
        }
      })


      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
