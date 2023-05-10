-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end
local which_key = require("wf.builtin.which_key")

-- Move to window using the movement keys
-- map("n", "<left>", "<C-w>h")
-- map("n", "<down>", "<C-w>j")
-- map("n", "<up>", "<C-w>k")
-- map("n", "<right>", "<C-w>l")

map("n", "<F1>", ":Telescope project<CR>")
map("n", "<F2>", ":WhichKey<CR>")
map("n", "<F3>", ":Telescope live_grep_args<CR>")
map("n", "<F4>", ":Lspsaga outline<CR>")
map("n", "<F5>", ":Telescope treesitter<CR>")
-- map("n", "<F6>", ":Lspsaga term_toggle<CR>")
map("n", "<F6>", ":ToggleTerm size=40<CR>")
map("n", "<leader>F", ":Lspsaga lsp_finder<CR>")

map("i", "jk", "<ESC>")
map("n", "<leader>j", "<Cmd>BufferLinePick<CR>", { desc = "[b]uffer [j]ump" })
-- map("n", "<F6>", ":Lspsaga term_toggle<CR>")
map("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
map("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
map("n", "<Leader>A", function()
  vim.lsp.buf.code_action({
    context = {
      only = {
        "source",
      },
      diagnostics = {},
    },
  })
end, { desc = "Source Action" })
-- map(
--   "n",
--   "<Leader>",
--   which_key({ text_insert_in_advance = "<Leader>" }),
--   { noremap = true, silent = true, desc = "[wf.nvim] which-key /" }
-- )
-- Move line(s), like vscode
-- https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/keymappings.lua
-- map("n", "<A-j>", ":m .+1<cr>==")
-- map("n", "<A-k>", ":m .-2<cr>==")
-- map("i", "<A-j>", "<esc>:m .+1<cr>==gi")
-- map("i", "<A-k>", "<esc>:m .-2<cr>==gi")
-- map("v", "<A-j>", ":m '>+1<cr>gv-gv")
-- map("v", "<A-k>", ":m '<-2<cr>gv-gv")
