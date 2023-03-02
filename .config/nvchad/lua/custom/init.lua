vim.cmd [[

   augroup ilikecursorline
      autocmd VimEnter * :highlight CursorLine guibg=#292e42 ctermbg=black term=none cterm=none
   augroup END

]]

-- Scopes
-- vim.o = Obtém ou define as configurações gerais.
-- vim.wo = Obtém ou define opções no escopo da janela.
-- vim.bo = Obtém ou define opções com escopo de buffer.
-- vim.g = Obtém ou define variáveis globais. Geralmente é o namespace onde você encontrará variáveis definidas por plug-ins. O único que sei que não está vinculado a um plugin é a chave líder.
-- vim.env = Obtém ou define variáveis de ambiente.
-- vim.opt = Com vim.opt podemos definir configurações globais, de janela e de buffer.


vim.o.ruler = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.ignorecase = true -- para procurar enquanto digita
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.background = 'dark'
vim.o.termguicolors = true
vim.o.hidden = true
vim.o.updatetime = 300
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.completeopt = 'menuone,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.showmode = false
vim.o.clipboard = 'unnamedplus'
vim.opt.cursorline = true
vim.o.shell = 'sh'

vim.wo.number = true
vim.wo.relativenumber = false
--vim.wo.signcolumn = 'auto:2' -- espaço da primeira coluna dos números
vim.wo.wrap = true -- quebrar linhas
vim.o.colorcolumn = '80'
vim.o.modeline = true -- usa as variaveis # vim:ft=sh:

vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.bo.softtabstop = 4
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true

-- Diretorios
vim.o.backup = false
vim.o.swapfile = false
vim.opt.wildignore:append { '*/tmp/*', '*.so', '*.swp', '.zip', '.pyc', '*.db', '.sqlite', '.git', '.gz' }

vim.cmd('language pt_BR.utf-8')
vim.wo.list = true
-- vim.opt.listchars = {
--    space = "⋅",
--    eol = "↴",
-- }

vim.g.markdown_fenced_languages = { 'sh', 'vim' }

vim.g.termbufm_direction_cmd = 'new'

vim.g.maplocalleader = "\\"

-- Execute codigo no neovim, auto-fechar nvim-tree,
vim.api.nvim_exec([[
augroup exe_code
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>r :sp<CR> :term python3 %<CR> :startinsert<CR>
    autocmd FileType javascript nnoremap <buffer> <localleader>r :sp<CR> :term node %<CR> :startinsert<CR>
    autocmd FileType bash,sh nnoremap <buffer> <localleader>r :sp<CR> :term bash %<CR> :startinsert<CR>
    autocmd FileType lua nnoremap <buffer> <localleader>r :sp<CR> :term lua %<CR> :startinsert<CR>
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
    autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
    autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup End
    ]], true)
