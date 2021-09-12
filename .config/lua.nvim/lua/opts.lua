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
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.showmode = false
vim.o.clipboard = 'unnamedplus'
vim.opt.cursorline = true
vim.o.shell = 'sh'

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'number'
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
vim.opt.listchars = {
    space = "⋅",
--    eol = "↴",
}

vim.g.markdown_fenced_languages = { 'sh', 'vim' }

vim.g.termbufm_direction_cmd = 'new'

-- config Color Scheme
vim.cmd[[colorscheme tokyonight]]
vim.g.tokyonight_style = "night"

-- NvimTree
vim.g['nvim_tree_ignore'] = { '.git', 'node_modules', '.cache' }
vim.g['nvim_tree_gitignore'] = 1
vim.g['nvim_tree_auto_close'] = 1
vim.g['nvim_tree_hide_dotfiles'] = 0
vim.g['nvim_tree_git_hl'] = 1
vim.g['nvim_tree_highlight_opened_files'] = 1

-- Indent-blankline
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 blend=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B blend=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 blend=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 blend=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF blend=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD blend=nocombine]]

vim.g['indent_blankline_char_highlight_list'] = true
