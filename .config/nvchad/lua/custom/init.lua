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
