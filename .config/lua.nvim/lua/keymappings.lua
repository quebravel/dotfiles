local mapper = function( mode, key, result ) vim.api.nvim_set_keymap( mode, key, result, { noremap = true, silent = true } )
end

vim.g.mapleader = ' '
vim.b.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.b.maplocalleader = '\\'

-- NvimTree
mapper( 'n', '<leader>n',':NvimTreeToggle<CR>' )

-- Buffer
mapper( 'n','<Tab>',':BufferLineCycleNext<CR>' )
mapper( 'n','<S-Tab>',':BufferLineCyclePrev<CR>' )

-- Scroll para comprar diff | vefificar depois
mapper( 'n', '<leader>w', ':windo set scrollbind<CR>' )
mapper( 'n', '<leader>S-w', ':windo set noscrollbind<CR>' )

-- Navegando nas janelas
mapper( 'n', '<C-j>', '<C-w>j' )
mapper( 'n', '<C-k>', '<C-w>k' )
mapper( 'n', '<C-l>', '<C-w>l' )
mapper( 'n', '<C-h>', '<C-w>h' )

-- Move visual block
mapper( 'x', 'J', ':move \'>+1<CR>gv-gv\\' )
mapper( 'x', 'K', ':move \'<-2<CR>gv-gv\\' )

-- Fugitive
mapper( 'n', '<leader>g', ':Gvdiffsplit<CR>' )
mapper( 'n', '<leader>l', ':Gclog<CR>' )

-- Nvim comment
mapper( '', '<leader>/', ':CommentToggle<CR>' )

-- Melhor identacao (ctrl+v)
mapper( 'x', '<', '<gb' )
mapper( 'x', '>', '>gb' )

-- Tecla para fechar buffer
mapper( 'n', '<leader>b', ':BufferLinePick<CR>' )
mapper( 'n', '<leader>x', ':BufferLinePickClose<CR>' )

-- Limpar pesquisa (highlight)
mapper( 'n', '<space><space>', ':noh<CR>' )

-- Telescope
mapper( 'n', '<leader>ff', ':Telescope find_files hidden=true<CR>' )
mapper( 'n', '<leader>fb', ':Telescope buffers<CR>' )
mapper( 'n', '<leader>fh', ':Telescope help_tags<CR>' )
mapper( 'n', '<leader>fw', ':Telescope file_browser<CR>' )
mapper( 'n', '<leader>fo', ':Telescope oldfiles<CR>' )
mapper( 'n', '<leader>fc', ':Telescope git_commits<CR>' )

-- Dashboard
mapper( 'n', '<leader>d', ':Dashboard<CR>' )

-- Zen-Mode
mapper( 'n', '<leader>z', ':ZenMode<CR>' )

-- Execute codigo no neovim
vim.api.nvim_exec([[
augroup exe_code
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>r :sp<CR> :term python3 %<CR> :startinsert<CR>
    autocmd FileType javascript nnoremap <buffer> <localleader>r :sp<CR> :term node %<CR> :startinsert<CR>
    autocmd FileType bash,sh nnoremap <buffer> <localleader>r :sp<CR> :term bash %<CR> :startinsert<CR>
    autocmd FileType lua nnoremap <buffer> <localleader>r :sp<CR> :term lua %<CR> :startinsert<CR>

    autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
augroup End
    ]], true)
