return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>ue",
        function()
          require("edgy").toggle()
        end,
        desc = "Edgy Toggle",
      },
      {
        "<leader>uE",
        function()
          require("edgy").select()
        end,
        desc = "Edgy Select Window",
      },
    },
  },
  {
    "google/executor.nvim",
    config = function()
      require("executor").setup({})
      vim.api.nvim_set_keymap("n", "<leader>er", "<Cmd>ExecutorRun<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>ev", "<Cmd>ExecutorToggleDetail<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>ec", "<Cmd>ExecutorSetCommand<CR>", {})
    end,
  },
  -- {
  --   "jedrzejboczar/toggletasks.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "akinsho/toggleterm.nvim",
  --     "nvim-telescope/telescope.nvim/",
  --   },
  -- },
  {
    "mrjones2014/legendary.nvim",
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },
  {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup({
        max_length = 0, -- Maximum length of selection (0 for no limit)
        silent = false, -- Disable message on successful copy
        trim = false, -- Trim surrounding whitespaces before copy
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
    "karb94/neoscroll.nvim",
    enabled = true,
    config = function()
      require("neoscroll").setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false, -- Disable "Performance Mode" on all buffers.
      })
    end,
  },
  {
    "IndianBoy42/tree-sitter-just",
    config = function()
      require("nvim-treesitter.install").compilers = { "gcc-11" }
      require("tree-sitter-just").setup({})
    end,
  },
  --  highlight-undo
  --  https://github.com/tzachar/highlight-undo.nvim
  --  BUG: Currently only works for redo.
  {
    "tzachar/highlight-undo.nvim",
    event = "VeryLazy",
    opts = {
      hlgroup = "CurSearch",
      duration = 150,
      keymaps = {
        { "n", "u", "undo", {} }, -- If you remap undo/redo, change this
        { "n", "<C-r>", "redo", {} },
      },
    },
    config = function(_, opts)
      require("highlight-undo").setup(opts)
    end,
  },
  -- better increase/descrease
  {
    "monaqa/dial.nvim",
    enabled = false,
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
  { "akinsho/toggleterm.nvim", version = "*", config = true },
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
    "akinsho/flutter-tools.nvim",
    event = "VeryLazy",
  },
  -- {
  --   "ray-x/go.nvim",
  --   dependencies = { -- optional packages
  --     "ray-x/guihua.lua",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("go").setup({
  --       lsp_inlay_hints = { enable = false },
  --     })
  --   end,
  --   -- opts = {
  --   --   lsp_inlay_hints = { enable = false },
  --   -- },
  --   event = { "CmdlineEnter" },
  --   ft = { "go", "gomod" },
  --   build = ':lua require("go.install").update_all_sync()',
  -- },
  {
    "rafcamlet/nvim-luapad",
    event = "VeryLazy",
  },
  {
    "LhKipp/nvim-nu",
  },
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    config = true,
    enabled = false,
    keys = {
      {
        "<Leader>d",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Dropbar: Pick mode",
      },
    },
  },
  -- {
  --   "roobert/activate.nvim",
  --   keys = {
  --     {
  --       "<leader>P",
  --       '<CMD>lua require("activate").list_plugins()<CR>',
  --       desc = "Plugins",
  --     },
  --   },
  -- },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   -- dev = true,
  --   branch = "v3.x",
  --   opts = {
  --     filesystem = {
  --       bind_to_cwd = true,
  --       -- follow_current_file = {
  --       --   enabled = false,
  --       --   leave_dirs_open = false,
  --       -- },
  --     },
  --     -- buffers = {
  --     --   follow_current_file = {
  --     --     enabled = false,
  --     --     leave_dirs_open = false,
  --     --   },
  --     -- },
  --   },
  --   config = function(_, opts)
  --     --     -- code
  --     require("neo-tree").setup(opts)
  --   end,
  -- },
  {
    "L3MON4D3/LuaSnip",
    enabled = true,
  },
  {
    "daog1/lspsaga.nvim",
    branch = "addOutlineHideconfig",
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
        hide_kind = { "Variable", "Field" },
        keys = {
          expand_or_jump = "<cr>",
        },
      },
      callhierarchy = {
        show_detail = false,
        keys = {
          edit = "<cr>",
        },
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
    event = "VeryLazy",
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
    opts = {
      timeout = 500,
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
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    lazy = true,
    keys = {
      {
        "<leader>a",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
    },
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath("config") .. "/sessions/"), -- directory where session files are saved
        options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
      })
    end,
  },
  -- markdown preview

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        show_end_of_line = true,
        space_char_blankline = " ",
      })
    end,
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",

        -- Move current line in Normal mode
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },

      -- Options which control moving behavior
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    },
  },
}
