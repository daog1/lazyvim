return {
  {
    "telescope.nvim",
    opts = {
      pickers = {
        lsp_references = {
          fname_width = 50,
          trim_text = true,
        },
      },
    },
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
    config = function()
      require("telescope").load_extension("project")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    opts = {},
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },
}
