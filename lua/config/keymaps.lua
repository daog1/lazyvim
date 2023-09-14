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

-- map("n", "<F1>", ":Telescope project<CR>")
map("n", "<F2>", ":WhichKey<CR>")
map("n", "<F3>", ":Telescope live_grep_args<CR>")
--map("n", "<F4>", ":Telescope find_files hidden=true<CR>")
map("n", "<F4>", ":FzfLua files<CR>")
map("n", "<leader><F4>", ":Telescope buffers<CR>")
--map("n", "<F5>", ":Telescope treesitter<CR>")
-- map("n", "<F6>", ":Lspsaga term_toggle<CR>")
--
map("n", "<F6>", ":ToggleTerm size=20<CR>")
map("n", "<leader>F", ":Lspsaga lsp_finder<CR>")
map("n", "<leader>o", ":Lspsaga outline<CR>")
map("n", "<leader>p", ":Telescope projects<CR>")

map("i", "jk", "<ESC>")
map("n", "<leader>z", ":Neotree toggle<CR>")
map("n", "<leader>j", "<Cmd>BufferLinePick<CR>", { desc = "[b]uffer [j]ump" })
-- map("n", "<F6>", ":Lspsaga term_toggle<CR>")
map("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
map("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
map("n", "<Leader>T", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics (Trouble)" })
map("n", "<Leader>t", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics (Trouble)" })
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

-- VSCode style saving
vim.keymap.set("n", "<C-s>", "<CMD>w!<CR>")
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<ESC><CMD>w!<CR>")
vim.keymap.set({ "n", "i", "v" }, "<C-q>", "<ESC><CMD>q!<CR>")
vim.keymap.set("i", "<C-e>", "<C-o>A")
vim.keymap.set("n", "U", "<C-R>", { desc = "Redo", silent = true })

-- vim.api.nvim_set_keymap("n", "K", "<C-u>", { silent = true })
-- vim.api.nvim_set_keymap("n", "J", "<C-e>", { silent = true })
-- vim.api.nvim_set_keymap("x", "K", "<C-u>", { silent = true })
-- vim.api.nvim_set_keymap("x", "J", "<C-e>", { silent = true })
--
-- A couple Helix/Kakoune keymaps
map({ "n", "o", "x" }, "gl", "$", { desc = "Go to the last character in the line" })
map({ "n", "o", "x" }, "gh", "0", { desc = "Go to the first character in the line" })
-- map({ "n", "o", "x" }, "gs", "^", { desc = "Go to the first non-blank character in the line" })
