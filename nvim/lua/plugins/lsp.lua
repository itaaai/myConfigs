-- lua/plugins/lsp.lua
return {
  -- LSP core
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Server installer
      { "williamboman/mason.nvim", config = true },
      { "williamboman/mason-lspconfig.nvim" },

      -- Completion stack
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Nice Lua LSP for Neovim configs
      "folke/neodev.nvim",
    },
    config = function()
      -- =========================
      -- UI/diagnostics preferences
      -- =========================
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        severity_sort = true,
        float = { border = "rounded" },
      })
      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

      -- =========================
      -- nvim-cmp (completion)
      -- =========================
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
          { name = "luasnip" },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      -- Capabilities (cmp + inlay hints + clangd offset fix)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- clangd often wants utf-16 to avoid jump/rename glitches
      capabilities.offsetEncoding = { "utf-16" }

      -- Common on_attach to set keymaps once per server
      local on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gt", vim.lsp.buf.type_definition, "Type definition")
        map("n", "K",  vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
        map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")

        -- Inlay hints (Neovim 0.10+)
        if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end

      -- Mason + mason-lspconfig
      require("mason").setup({
        ui = { border = "rounded" },
      })

      local servers = {
        -- ===== C++ =====
        clangd = {
          cmd = { "clangd",
            "--background-index",
            "--clang-tidy",
            "--completion-style=detailed",
            "--header-insertion=iwyu",
          },
          init_options = { clangdFileStatus = true },
        },

        -- ===== Python =====
        -- prefer basedpyright (faster, modern settings)
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true, -- we'll let ruff handle imports
              analysis = {
                typeCheckingMode = "standard",
                autoImportCompletions = true,
              },
            },
          },
        },
        -- ruff-lsp for linting/quickfixes (and fast formatting)
        ruff = {
          init_options = { settings = { args = {} } },
        },

        -- ===== Useful extras =====
        cmake = {},
        bashls = {},
        jsonls = {},
        yamlls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
      }

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      require("neodev").setup({}) -- better Lua LSP for Neovim

      for name, cfg in pairs(servers) do
        cfg.capabilities = capabilities
        cfg.on_attach = on_attach
        lspconfig[name].setup(cfg)
      end
    end,
  },

  -- Format on save (fast & simple)
  {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Large files? Skip auto-format
        local max = 512 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size > max then return end
        return { lsp_fallback = true, timeout_ms = 1500 }
      end,
      formatters_by_ft = {
        -- C/C++
        c = { "clang_format" },
        cpp = { "clang_format" },

        -- Python: prefer ruff_format; fall back to black if installed
        python = { "ruff_format", "black" },

        -- Misc
        json = { "jq" },
        yaml = { "yamlfmt", "prettier" },
        lua = { "stylua" },
        sh  = { "shfmt" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      -- Manual format key
      vim.keymap.set({ "n", "v" }, "<leader>f", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format file/range" })
    end,
  },

  -- (Optional) Extra linters if you like them separate from LSP
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "ruff" }, -- ruff CLI (works alongside ruff-lsp if you want)
        sh = { "shellcheck" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
}

