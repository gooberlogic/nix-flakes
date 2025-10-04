require("nvchad.configs.lspconfig").defaults()

-- MasonInstallAll
local servers = { "html", "cssls", "rust_analyzer", "typescript-language-server"}

vim.lsp.config('typescript-language-server', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
})

vim.lsp.enable(servers)


-- https://github.com/neovim/neovim/issues/33391#issuecomment-2788183428
vim.defer_fn(function()
    local mode = vim.api.nvim_get_mode().mode
    vim.lsp.inlay_hint.enable(mode == 'n' or mode == 'v', { bufnr = bufnr })
end, 500)
