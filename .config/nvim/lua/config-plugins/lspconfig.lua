-- lsp https://www.chrisatmachine.com/Neovim/27-native-lsp/
require'lspconfig'.pyright.setup{
    autostart = false
}

require'lspconfig'.bashls.setup{
    autostart = true
}

-- require'lspconfig'.sumneko_lua.setup{
--     autostart = false
-- }
