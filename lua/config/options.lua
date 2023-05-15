-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- local float = require("utls.opts").float
if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font Mono:H14"
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()
end

local opt = vim.opt

opt.relativenumber = false
opt.tabstop = 4
opt.termguicolors = true
-- opt.clipboard = "*"
-- opt.clipboard = unnamedplus
-- popup, float
-- opt.winblend = float.winblend
-- opt.pumblend = float.pumblend
-- opt.pumheight = 10
--
local function copy(lines, _)
  require("osc52").copy(table.concat(lines, "\n"))
end

local function paste()
  return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end

-- vim.g.clipboard = {
--   name = "osc52",
--   copy = { ["+"] = copy, ["*"] = copy },
--   paste = { ["+"] = paste, ["*"] = paste },
-- }
--
-- -- Now the '+' register will copy to system clipboard using OSC52
-- vim.keymap.set("n", "<leader>c", '"+y')
-- vim.keymap.set("n", "<leader>cc", '"+yy')
