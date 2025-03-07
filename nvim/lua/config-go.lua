
require 'go'.setup({
  goimports = 'gopls', -- if set to 'gopls' will use golsp format
  gofmt = 'gopls', -- if set to gopls will use golsp format
  tag_transform = false,
  test_dir = '',
  comment_placeholder = '👻 ',
  lsp_cfg = true, -- false: use your own lspconfig
  lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = true, -- use on_attach from go.nvim
  dap_debug = true,
})

local protocol = require'vim.lsp.protocol'

local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})

local languages = {
  "go",
  "gowork",
  "gomod",
  "gosum",
  "sql",
  "gotmpl",
  "json",
  "comment"
}

for _, lang in ipairs(languages) do
  local ok, _ = pcall(function()
    require("nvim-treesitter.install").ensure_installed(lang)
  end)
  if not ok then
    print("Failed to install " .. lang .. " parser")
  end
end

