require "nvchad.options"

local o = vim.o
local g = vim.g
local a = vim.api

o.scrolloff = 8
o.title = true

o.ignorecase = true

o.smartindent = false
o.shiftwidth = 2
o.softtabstop = 2

o.expandtab = true
o.number = true
o.relativenumber = true

o.incsearch = true
o.hlsearch = false

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

o.cursorlineopt = "number"

a.nvim_create_user_command('T', function()
  vim.cmd('tabnew')
  vim.cmd('terminal')
end, {})
