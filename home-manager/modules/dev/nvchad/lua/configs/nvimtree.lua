require("nvim-tree").setup({
  --hijack_directories = {
  --  enable = true,
  --  auto_open = true,
  --},
  git = {
    ignore = false,
  },
  on_attach = function(bufnr)
    local treeapi = require("nvim-tree.api")

    treeapi.config.mappings.default_on_attach(bufnr)

    local function opts(desc)
      return {
        desc = "nvim-tree: " .. desc,
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true,
      }
    end

    vim.keymap.set("n", "l", treeapi.node.open.edit, opts("Open"))
    vim.keymap.set("n", "h", treeapi.node.navigate.parent_close, opts("Close Directory"))
  end
})
