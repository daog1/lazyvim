return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "simrat39/rust-tools.nvim" },
    opts = {
      servers = {
        -- Ensure mason installs the server
        golangci_lint_ls = {},
        gopls = {},
        solidity = {
          cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
          filetypes = { "solidity" },
          -- require("lspconfig.util").root_pattern "foundry.toml",
          root_dir = require("lspconfig.util").find_git_ancestor,
          single_file_support = true,
          includePath = "",
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              procMacro = { enable = true },
              cargo = { allFeatures = true },
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },
      },
      setup = {

        gopls = function(_, opts)
          require("lazyvim.util").on_attach(function(client, _)
            if client.name == "gopls" then -- workaround for gopls not supporting semanticTokensProvider https://github.com/golang/go/issues/54531#issuecomment-1464982242
              if not client.server_capabilities.semanticTokensProvider then
                local semanticTokens = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semanticTokens.tokenTypes,
                    tokenModifiers = semanticTokens.tokenModifiers,
                  },
                  range = true,
                }
              end
            end
          end)
          opts.settings = {
            gopls = {
              -- lsp_inlay_hints = { enable = false },
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          }
        end,
      },
    },
  },
  -- {
  --   -- RUST LSP
  --   "simrat39/rust-tools.nvim",
  --   event = "VeryLazy",
  --   dependencies = "neovim/nvim-lspconfig",
  --   config = function()
  --     require("rust-tools").setup({
  --       -- rust-tools options
  --       tools = {
  --         autoSetHints = true,
  --         inlay_hints = {
  --           show_parameter_hints = true,
  --           parameter_hints_prefix = "<- ",
  --           other_hints_prefix = "=> ",
  --           -- auto = false,
  --         },
  --       },
  --       -- all the opts to send to nvim-lspconfig
  --       -- these override the defaults set by rust-tools.nvim
  --       --
  --       -- REFERENCE:
  --       -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
  --       -- https://rust-analyzer.github.io/manual.html#configuration
  --       -- https://rust-analyzer.github.io/manual.html#features
  --       --
  --       -- NOTE: The configuration format is `rust-analyzer.<section>.<property>`.
  --       --       <section> should be an object.
  --       --       <property> should be a primitive.
  --       server = {
  --         on_attach = function(client, bufnr)
  --           require("shared/lsp")(client, bufnr)
  --           require("illuminate").on_attach(client)
  --
  --           local bufopts = {
  --             noremap = true,
  --             silent = true,
  --             buffer = bufnr,
  --           }
  --           vim.keymap.set("n", "<leader><leader>rr", "<Cmd>RustRunnables<CR>", bufopts)
  --           vim.keymap.set("n", "K", "<Cmd>RustHoverActions<CR>", bufopts)
  --         end,
  --         ["rust-analyzer"] = {
  --           assist = {
  --             importEnforceGranularity = true,
  --             importPrefix = "create",
  --           },
  --           cargo = { allFeatures = true },
  --           checkOnSave = {
  --             -- default: `cargo check`
  --             command = "clippy",
  --             allFeatures = true,
  --           },
  --         },
  --         inlayHints = {
  --           -- NOT SURE THIS IS VALID/WORKS 😬
  --           lifetimeElisionHints = {
  --             enable = true,
  --             useParameterNames = true,
  --           },
  --         },
  --       },
  --     })
  --   end,
  -- },
  -- inlay hints
  {
    "lvimuser/lsp-inlayhints.nvim",
    branch = "anticonceal",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
    end,
  },
}
