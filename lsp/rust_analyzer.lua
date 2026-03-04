 vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },

  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', '.git' },


  settings = {
    ['rust-analyzer'] = {
      cargo = { targetDir = true },
      check = { command = 'clippy' },
      inlayHints = {
        bindingModeHints = { enabled = true },
        closureCaptureHints = { enabled = true },
        closureReturnTypeHints = { enable = 'always' },
        maxLength = 200,
      },
      rustc = { source = 'discover' },
    }
  },
})
