set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc


lua vim.lsp.config('*', {
            \   capabilities = {
            \     textDocument = {
            \       semanticTokens = {
            \         multilineTokenSupport = true,
            \       }
            \     }
            \   },
            \   root_markers = { '.git' },
            \ })

lua vim.lsp.enable('rust_analyzer')
lua vim.lsp.enable('ty')


lua vim.diagnostic.enable = true
lua vim.diagnostic.config({ virtual_lines = true })
