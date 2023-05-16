-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    'mrjones2014/legendary.nvim',
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },
{
   'ojroques/nvim-osc52',
    config=function ()
      require('osc52').setup({
        max_length = 0,      -- Maximum length of selection (0 for no limit)
        silent     = false,  -- Disable message on successful copy
        trim       = false,  -- Trim surrounding whitespaces before copy
      })
    end,
  },
  -- better yank/paste
  {
    "kkharji/sqlite.lua",
    enabled = function()
      return not jit.os:find("Windows")
    end,
  },
  {
    "gbprod/yanky.nvim",
    enabled = false,
    event = "BufReadPost",
    config = function()
      -- vim.g.clipboard = {
      --   name = "xsel_override",
      --   copy = {
      --     ["+"] = "xsel --input --clipboard",
      --     ["*"] = "xsel --input --primary",
      --   },
      --   paste = {
      --     ["+"] = "xsel --output --clipboard",
      --     ["*"] = "xsel --output --primary",
      --   },
      --   cache_enabled = 1,
      -- }

      require("yanky").setup({
        highlight = {
          timer = 150,
        },
        ring = {
          storage = jit.os:find("Windows") and "shada" or "sqlite",
        },
      })

      vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

      vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

      vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
      vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
      vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
      vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

      vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
      vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
      vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
      vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

      vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
      vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

      vim.keymap.set("n", "<leader>P", function()
        require("telescope").extensions.yank_history.yank_history({})
      end, { desc = "Paste from Yanky" })
    end,
  },

  -- better increase/descrease
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    -- splutylua: ignore
    keys = {
      {
        "<C-a>",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
        desc = "Increment",
      },
      {
        "<C-x>",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
        desc = "Decrement",
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })
    end,
  },

  -- add gruvbox
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup({
        mappings = {
          set_next = "m,",
          next = "m]",
          preview = "m:",
          set_bookmark0 = "m0",
          prev = false, -- pass false to disable only this default mapping
        },
      })
    end,
  },
  {"Cassin01/wf.nvim", version = "*", 
    config = function() 
    require("wf").setup() 
  end
  },
 {'akinsho/toggleterm.nvim', version = "*", config = true},
    {
    -- Winbar
    -- FIXME: despite the fix from #35, `navic` still refuses to work
    --  with barbecue.
    --  After further investigation, I found that the bug is reproducible in my older
    --  _lualine_ winbar, which begs the question if it's a navic bug or a bug
    --  with lazyvim's handling of navic (particularly, how it attaches to a
    --  LSP/buf).
    "utilyre/barbecue.nvim", -- Wait for my PR to get merged
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- The navic config that ships with Lazyvim already attaches
      -- for us, besides `barbecue/issue#35`
      attach_navic = false,
      -- Window number as leading section
      lead_custom_section = function(_, winnr)
        return string.format("  %d 󱋱 ", vim.api.nvim_win_get_number(winnr))
      end,

      exclude_filetypes = {
        "DressingInput",
        "neo-tree",
        "toggleterm",
        "Trouble",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      {
        -- Scope buffers to tabs!
        "tiagovla/scope.nvim",
        config = true,
      },
    },
    opts = {
      options = {
        separator_style = "slant",
        always_show_bufferline = true,
      },
    },
    keys = {
      { "<leader>bj", "<Cmd>BufferLinePick<CR>", desc = "[b]uffer [j]ump" },
      { "<S-Right>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
      { "<S-Left>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },
    },
  },
  {
    'akinsho/flutter-tools.nvim',
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        golangci_lint_ls = {},
        gopls = {},
        solidity = {
                cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
                filetypes = { 'solidity' },
                -- require("lspconfig.util").root_pattern "foundry.toml",
                root_dir = require("lspconfig.util").find_git_ancestor,
                single_file_support = true,
                includePath = "",
        },
      },
      setup = {
        gopls = function(_, opts)
          require("lazyvim.util").on_attach(function(client, _)
            if client.name == "gopls" then
              -- workaround for gopls not supporting semanticTokensProvider
              -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
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
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()'
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    config = function()
      require("telescope").load_extension("live_grep_args")
      vim.api.nvim_set_keymap("n", "<C-S-F>", "<CMD>Telescope live_grep_args<CR>", { noremap = true })
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    config = function ()
      require("telescope").load_extension("project")
    end,
  },
  {
    'rafcamlet/nvim-luapad',
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts ={
      filesystem = {
        bind_to_cwd = true,
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    enabled = true,
  },
  {
    "daog1/lspsaga.nvim",
    branch = 'addOutlineHideconfig',
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    event = "BufReadPre",
    opts = {
      symbol_in_winbar = {
        enable = false,
      },
      outline = {
        auto_preview = false,
        win_width = 50,
        hide_kind={"Variable","Field"},
        keys = {
          expand_or_jump = '<cr>',
        },
      },
      callhierarchy = {
        show_detail = false,
        keys ={
          edit='<cr>',
        }
      },
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)
    end,
  },
  {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
          "go",
        },
      },
  },
  {
     "echasnovski/mini.nvim",
  },
  {
    "sindrets/diffview.nvim",
  },
-- better text-objects
  {
    "echasnovski/mini.ai",
    -- keys = {
    --   { "a", mode = { "x", "o" } },
    --   { "i", mode = { "x", "o" } },
    -- },
    event = "VeryLazy",
    keys = { { "[f", desc = "Prev function" }, { "]f", desc = "Next function" } },
    dependencies = { "nvim-treesitter-textobjects" },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
      -- add treesitter jumping
      ---@param capture string
      ---@param start boolean
      ---@param down boolean
      local function jump(capture, start, down)
        local rhs = function()
          local parser = vim.treesitter.get_parser()
          if not parser then
            return vim.notify("No treesitter parser for the current buffer", vim.log.levels.ERROR)
          end

          local query = vim.treesitter.get_query(vim.bo.filetype, "textobjects")
          if not query then
            return vim.notify("No textobjects query for the current buffer", vim.log.levels.ERROR)
          end

          local cursor = vim.api.nvim_win_get_cursor(0)

          ---@type {[1]:number, [2]:number}[]
          local locs = {}
          for _, tree in ipairs(parser:trees()) do
            for capture_id, node, _ in query:iter_captures(tree:root(), 0) do
              if query.captures[capture_id] == capture then
                local range = { node:range() } ---@type number[]
                local row = (start and range[1] or range[3]) + 1
                local col = (start and range[2] or range[4]) + 1
                if down and row > cursor[1] or (not down) and row < cursor[1] then
                  table.insert(locs, { row, col })
                end
              end
            end
          end
          return pcall(vim.api.nvim_win_set_cursor, 0, down and locs[1] or locs[#locs])
        end

        local c = capture:sub(1, 1):lower()
        local lhs = (down and "]" or "[") .. (start and c or c:upper())
        local desc = (down and "Next " or "Prev ") .. (start and "start" or "end") .. " of " .. capture:gsub("%..*", "")
        vim.keymap.set("n", lhs, rhs, { desc = desc })
      end

      for _, capture in ipairs({ "function.outer", "class.outer" }) do
        for _, start in ipairs({ true, false }) do
          for _, down in ipairs({ true, false }) do
            jump(capture, start, down)
          end
        end
      end
      -- register all text objects with which-key
      if require("lazyvim.util").has("which-key.nvim") then
        ---@type table<string, string|table>
        local i = {
          [" "] = "Whitespace",
          ['"'] = 'Balanced "',
          ["'"] = "Balanced '",
          ["`"] = "Balanced `",
          ["("] = "Balanced (",
          [")"] = "Balanced ) including white-space",
          [">"] = "Balanced > including white-space",
          ["<lt>"] = "Balanced <",
          ["]"] = "Balanced ] including white-space",
          ["["] = "Balanced [",
          ["}"] = "Balanced } including white-space",
          ["{"] = "Balanced {",
          ["?"] = "User Prompt",
          _ = "Underscore",
          a = "Argument",
          b = "Balanced ), ], }",
          c = "Class",
          f = "Function",
          o = "Block, conditional, loop",
          q = "Quote `, \", '",
          t = "Tag",
        }
        local a = vim.deepcopy(i)
        for k, v in pairs(a) do
          a[k] = v:gsub(" including.*", "")
        end

        local ic = vim.deepcopy(i)
        local ac = vim.deepcopy(a)
        for key, name in pairs({ n = "Next", l = "Last" }) do
          i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
          a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
        end
        require("which-key").register({
          mode = { "o", "x" },
          i = i,
          a = a,
        })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    enabled = false,
    opts ={
      timeout=500,
    },
  }, 
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  }
 }
