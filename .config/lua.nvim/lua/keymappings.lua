local mapper = function(mode, key, result) vim.api.nvim_set_keymap(mode, key, result, {noremap = true, silent = true})
end

vim.g.mapleader = ','
vim.b.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.b.maplocalleader = '\\'

-- mapper("n","w",":w<CR>")

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
mapper( 'v', 'J', ":m '>+1<CR>gv=gv" )
mapper( 'v', 'K', ":m '<-2<CR>gv=gv" )

-- Fugitive
mapper( 'n', '<leader>g', ':Gvdiffsplit<CR>' )
mapper( 'n', '<leader>l', ':Gclog<CR>' )

-- Nvim comment
mapper( '', '<leader>/', ':CommentToggle<CR>')

-- Execute codigo no neovim
vim.api.nvim_exec([[
augroup exe_code
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>r :sp<CR> :term python3 %<CR> :startinsert<CR>
    autocmd FileType javascript nnoremap <buffer> <localleader>r :sp<CR> :term node %<CR> :startinsert<CR>
    autocmd FileType bash,sh nnoremap <buffer> <localleader>r :sp<CR> :term bash %<CR> :startinsert<CR>
augroup End
    ]], true)
