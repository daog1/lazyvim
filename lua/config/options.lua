-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- local float = require("utls.opts").float
local opt = vim.opt

opt.relativenumber = false
opt.tabstop = 4
opt.termguicolors = true
opt.clipboard = "*"

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

vim.g.clipboard = {
  name = "osc52",
  copy = { ["+"] = copy, ["*"] = copy },
  paste = { ["+"] = paste, ["*"] = paste },
}
