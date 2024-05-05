require "base"
require "plugins"
require "colorscheme"
require "keymaps"

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  command = "PackerCompile",
})
